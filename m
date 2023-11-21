Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD397F37EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjKUVR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKUVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:17:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF0DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:17:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E044EC433C7;
        Tue, 21 Nov 2023 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700601443;
        bh=64R9kZykc4uPmmWYiruAQb246jsaatupVICtxfjMGrc=;
        h=From:To:Cc:Subject:Date:From;
        b=USrHtx/1czRsI3Lr0sNTdfpfuUETiOD3FnawXRS8xeU9f2IJucC1X6v8hZr7Ptv8O
         GOyy4mHCrr5j3KFYvLv2Mx8Cv30fm+WFTpdRItuoNJBBJMAHJwGoWFstabYFQQx0Ke
         ng3O3+//YJoiqPS/Sr0rs12eqntJQKXXYb7XpGNQVKiUSLTHVQNPiRF14YkPbYpIoF
         VUd+4bvAsKMBReHc0nElSZzXi0aqcHyMAZsPtPF1N7pW4q/c8ndFXgP31SbJw0Gkj1
         dkzGJn+20ALlnSmanywNkZJzGtHIME1Fwszj6Kzpf+ICN0wnuRY7zvBiTbSPlpExMX
         WEkJPmB931VUg==
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
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>
Subject: [PATCH v4 0/8] Extend struct tpm_buf to support sized buffers (TPM2B)
Date:   Tue, 21 Nov 2023 23:17:09 +0200
Message-ID: <20231121211717.31681-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
  tpm: Update &tpm_buf documentation
  tpm: Store the length of the tpm_buf data separately.
  tpm: TPM2B formatted buffers
  tpm: Add tpm_buf_read_{u8,u16,u32}
  KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers

 drivers/char/tpm/Makefile                 |   1 +
 drivers/char/tpm/tpm-buf.c                | 220 ++++++++++++++++++++++
 drivers/char/tpm/tpm-interface.c          |  26 +--
 include/keys/trusted_tpm.h                |   2 -
 include/linux/tpm.h                       | 112 +++--------
 security/keys/trusted-keys/trusted_tpm1.c |  23 ++-
 security/keys/trusted-keys/trusted_tpm2.c |  54 +++---
 7 files changed, 293 insertions(+), 145 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

-- 
2.42.1

