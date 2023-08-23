Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200CA786366
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjHWWaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbjHWW37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:29:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B6810F5;
        Wed, 23 Aug 2023 15:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5514563668;
        Wed, 23 Aug 2023 22:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D384C433C7;
        Wed, 23 Aug 2023 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692829791;
        bh=+BTa0iiOl5MKGJTbMH2NQ3i0H+h76fDQsRzTlmL2TKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXswDFyeMO4uQE4Pw332ov+8C9+dpiVGQW8cM87R4HVdqB1A5+sb+cw9RuA+iHCVu
         jIDwYH5ghryTaHtIytaW/PgtKqcONMhvkAev+uAbCPA9NbnCCfiL5xlUA6H9Fj2CIJ
         M2kY0a3TWsgYEtc1EZjyXvCnnCH7WvkCOdoHsykoKPa9BbGlkujy3nI+hTl5dn4UDi
         5StPCp+2DfvisYvRShrobiPX82u6ah5dV3qDqO7VfMQmB/Og8j128w/nqYuRM/rSgD
         lEA2bVIblYA2TtTO/SG/4xJ1yXrfyIuUbkbPM7t/6mn6K8FsuIwTAcUn6Zfi0Yu6NK
         wpWwptCiGcVVA==
Date:   Wed, 23 Aug 2023 16:30:51 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] wifi: mwifiex: Fix tlv_buf_left calculation
Message-ID: <698dc480d939e3ae490140db5c2f36eb84093594.1692829410.git.gustavoars@kernel.org>
References: <cover.1692829410.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692829410.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a TLV encoding scheme, the Length part represents the length after
the header containing the values for type and length. In this case,
`tlv_len` should be:

tlv_len == (sizeof(*tlv_rxba) - 1) - sizeof(tlv_rxba->header) + tlv_bitmap_len

Notice that the `- 1` accounts for the one-element array `bitmap`, which
1-byte size is already included in `sizeof(*tlv_rxba)`.

So, if the above is correct, there is a double-counting of some members
in `struct mwifiex_ie_types_rxba_sync`, when `tlv_buf_left` and `tmp`
are calculated:

968                 tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
969                 tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);

in specific, members:

drivers/net/wireless/marvell/mwifiex/fw.h:777
 777         u8 mac[ETH_ALEN];
 778         u8 tid;
 779         u8 reserved;
 780         __le16 seq_num;
 781         __le16 bitmap_len;

This is clearly wrong, and affects the subsequent decoding of data from
`event_buf` through `tlv_rxba`:

970                 tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;

Fix this by using `sizeof(tlv_rxba->header)` instead of `sizeof(*tlv_rxba)`
in the calculation of `tlv_buf_left` and `tmp`.

This results in the following binary differences before/after changes:

| drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
| @@ -4698,11 +4698,11 @@
|                 tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
| -    1da7:      lea    -0x11(%rbx),%edx
| +    1da7:      lea    -0x4(%rbx),%edx
|      1daa:      movzwl %bp,%eax
|  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:969
|                 tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
| -    1dad:      lea    0x11(%r15,%rbp,1),%r15
| +    1dad:      lea    0x4(%r15,%rbp,1),%r15
|  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:968
|                 tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
|      1db2:      mov    %edx,%ebx

The above reflects the desired change: avoid counting 13 too bytes;
which is the total size of the double-counted members in
`struct mwifiex_ie_types_rxba_sync`:

$ pahole -C mwifiex_ie_types_rxba_sync drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
struct mwifiex_ie_types_rxba_sync {
	struct mwifiex_ie_types_header header;           /*     0     4 */

     |-----------------------------------------------------------------------
     |  u8                         mac[6];               /*     4     6 */  |
     |	u8                         tid;                  /*    10     1 */  |
     |  u8                         reserved;             /*    11     1 */  |
     | 	__le16                     seq_num;              /*    12     2 */  |
     | 	__le16                     bitmap_len;           /*    14     2 */  |
     |  u8                         bitmap[1];            /*    16     1 */  |
     |----------------------------------------------------------------------|
								  | 13 bytes|
								  -----------

	/* size: 17, cachelines: 1, members: 7 */
	/* last cacheline: 17 bytes */
} __attribute__((__packed__));

Fixes: 99ffe72cdae4 ("mwifiex: process rxba_sync event")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 391793a16adc..d1d3632a3ed7 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -965,8 +965,8 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 			}
 		}
 
-		tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
-		tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
+		tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
+		tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
 		tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
 	}
 }
-- 
2.34.1

