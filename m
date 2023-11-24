Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F37F6A62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKXCCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXCCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33169D6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:02:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64764C433C8;
        Fri, 24 Nov 2023 02:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700791361;
        bh=uhsWY5tVG5Y63HOVcL4IYngiYr51naWkW3Dx8aoHbzg=;
        h=From:To:Cc:Subject:Date:From;
        b=SjX+uAKsDGEoGJCguOGpzJx6KpawiLiQcCxdcp5FuLQ6eV9jlWcjm+nVeX2KEJ6Wq
         V8Z2asyDXEBrERohpY8cpV9KoHQFMfcrz/hfaOxDaKG3dMesefm45lqqP3ao2ccXo8
         XBkKdWQE8dwG7G5RDrA85ShCGix+cZsHgzJYf1A2rBLTF+KyLIOOdqFIv1Nz+DLEOw
         EK7P/5TtSrfICfR+JBbKOxUioZhfHy3g/Bx/rtGq0nLI+6XEJbMnxelaCEKd16+x++
         wHyGv7oVrFSJbztT6YXrz5e5eb0EJTaLzSEL7Eof5cwmOm4dYvymqgPyFOpUjEAYj8
         Jsj8X4UepE8Mw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v6 0/8] Extend struct tpm_buf to support sized buffers (TPM2B)
Date:   Fri, 24 Nov 2023 04:02:29 +0200
Message-ID: <20231124020237.27116-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set extends struct tpm_buf to support TPM2 sized buffers, and
adds reader functions for parsing more complex response data.  It is
implemented to support smooth landing of [2]. Sealing of the TPM2 trusted
keys is updated to utilize the new functionality, and thus provides a
legit test case for it.

TPM2 sized buffer, i.e. the buffers in TPM2 format, are defined in the
section 10.4 of the TPM2 Structures [1] specification.

Here's the smoke test that I've run for TPM2:

/usr/lib/kselftests/run_kselftest.sh
tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
tpm2_evictcontrol -c key.ctxt 0x81000001
keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk 64" @u

[1] https://trustedcomputinggroup.org/resource/tpm-library-specification/
[2] https://lore.kernel.org/linux-integrity/20230403214003.32093-1-James.Bottomley@HansenPartnership.com/

v6:
- 7/8: fixed off-by-one error in the boundary check
v5:
- Fixed glitch in tpm_buf_read() reported by James Bottomley to the v4.
  Was forgotten from v4.
- Remove a spurious memset() call introduced in v4.
- Allow command buffer tag to be initially set to zero (caused spurious
  warnings).
v4:
- Cleaned up the bit too spread code changes based on the v3 review.
- For testing instructions see the previous cover letter, and use
  linux-v6.6.y branch:
  https://lore.kernel.org/linux-integrity/20231024011531.442587-1-jarkko@kernel.org/
v3:
- Resend with rebase to the latest upstream.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: William Roberts <bill.c.roberts@gmail.com> 
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>

James Bottomley (1):
  tpm: Move buffer handling from static inlines to real functions

Jarkko Sakkinen (7):
  tpm: Remove unused tpm_buf_tag()
  tpm: Remove tpm_send()
  tpm: Update struct tpm_buf documentation comments
  tpm: Store the length of the tpm_buf data separately.
  tpm: TPM2B formatted buffers
  tpm: Add tpm_buf_read_{u8,u16,u32}
  KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers

 drivers/char/tpm/Makefile                 |   1 +
 drivers/char/tpm/tpm-buf.c                | 222 ++++++++++++++++++++++
 drivers/char/tpm/tpm-interface.c          |  26 +--
 include/keys/trusted_tpm.h                |   2 -
 include/linux/tpm.h                       | 112 +++--------
 security/keys/trusted-keys/trusted_tpm1.c |  23 ++-
 security/keys/trusted-keys/trusted_tpm2.c |  54 +++---
 7 files changed, 295 insertions(+), 145 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

-- 
2.43.0

