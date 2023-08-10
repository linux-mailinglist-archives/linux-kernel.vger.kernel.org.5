Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0506877766B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHJLFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHJLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:05:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53721994;
        Thu, 10 Aug 2023 04:05:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb84194bf3so5560955ad.3;
        Thu, 10 Aug 2023 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691665533; x=1692270333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZNwX6BX5AQPN+unSBMh2stfRIj6tOKu7CYnBnKpHOo=;
        b=fLMH0z09jpbIUTMF2PGqdSyku77R0WqQ0sDRGWTzXWXtABt44FcIQtZISOcBQUuOo1
         +PniFeXyWmDTvnYz4WKsjUYGQp7CeUB5KB1RgGFTndpT6qOzL8I3jsedxnuxI8234VpW
         iNYeZpY2E6awMNz5tjEcLTlVhw/7b2NUWybrZchFl5njQ8u0v/TQtohH6nDAz+5WXIro
         Jv4yUyUj8zOCQMyYATTN+SU+Qz6utCaEcly3Sv+C0w+6fsziQI3F4pZ6lj98uU9dwYAq
         H7p7QtbBw1UHpuIOhOg7CaFRH8jZsk8la0JEHODRRsWJc7lSK5VonliqARh5nwXombm/
         aWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691665533; x=1692270333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZNwX6BX5AQPN+unSBMh2stfRIj6tOKu7CYnBnKpHOo=;
        b=H5cWjKbUAwBlVohT0xNo2zEW5YBvYUNOTsbwiIKQ1t2uzYvN4gXMstMPhQU9oKA17o
         vIUU9F9/mfi3mIu7VQLORadUDHryrsg+tmzkVtsYll7KhnqKsxHTpllDQhWh0C9tYkP0
         RtJPad534Bgs8NtgeX8MqfXNKgayiWtyMMjnIfHUKCu2InqyevWOGBc2a/FKLmeEPPJC
         AXKDjNh7/yo5KiTzPhJK0eBbSdM2Uim4lsNe2loOONXDPv+EGnzsamw2otdWcN/kcD6S
         nixD+xdfVO21jeQLz2bFXBg/wTFwCaRTBhZska28OUJBTt2eqSYz1fPNGN6i0cLt9YQj
         uxnQ==
X-Gm-Message-State: AOJu0YxrQZhpjFzgJ6hfHWjys0sjJ2RRrtAD7+MPrm5yJQh15l3Grndy
        JHN+vRiSBajQhT/TV0Av0UI=
X-Google-Smtp-Source: AGHT+IFpyZGd+kMxWfgW+ab88/WcuCmZPvVDSkEKkhwwIdnKNFCV9Y5hnB9SEK1Cwge9Ipk4U4bk0g==
X-Received: by 2002:a17:902:d353:b0:1bc:6845:deb5 with SMTP id l19-20020a170902d35300b001bc6845deb5mr1947971plk.36.1691665533047;
        Thu, 10 Aug 2023 04:05:33 -0700 (PDT)
Received: from localhost ([125.35.86.198])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b001bbdd44bbb6sm1428333plg.136.2023.08.10.04.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:05:32 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com
Cc:     eperezma@redhat.com, 18801353760@163.com,
        Andrew Melnychenko <andrew@daynix.com>, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Date:   Thu, 10 Aug 2023 19:04:05 +0800
Message-Id: <20230810110405.25558-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.

According to the VirtIO standard, "Field reserved MUST contain zeroes.
It is defined to make the structure to match the layout of
virtio_net_rss_config structure, defined in 5.1.6.5.7.".

Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
field in struct virtio_net_ctrl_rss, which corresponds to the
`reserved` field in struct virtio_net_hash_config, is not zeroed,
thereby violating the VirtIO standard.

This patch solves this problem by zeroing this field in
virtnet_init_default_rss().

Cc: Andrew Melnychenko <andrew@daynix.com>
Cc: stable@vger.kernel.org
Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1270c8d23463..8db38634ae82 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 		vi->ctrl->rss.indirection_table[i] = indir_val;
 	}
 
-	vi->ctrl->rss.max_tx_vq = vi->curr_queue_pairs;
+	vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
 	vi->ctrl->rss.hash_key_length = vi->rss_key_size;
 
 	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
-- 
2.34.1

