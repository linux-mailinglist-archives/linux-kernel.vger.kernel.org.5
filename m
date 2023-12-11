Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BEB80CA91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjLKNKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjLKNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:10:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55907C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:10:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A1C433C8;
        Mon, 11 Dec 2023 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702300218;
        bh=eN+xX6DmUW4iySUtNTiONSvtkTg9S6O6PBUBb147Eow=;
        h=From:Date:Subject:To:Cc:From;
        b=GnwrpM9N1KHskL0ItU5RfVm6tiiamVasCF5XI3q2oqOCYLQQsdeyEAELevJZReSEt
         1sG0pLtmb6hXzqCxqVpevH375oT26qR6f++eQ/c01GrKzYh3BEVNWccCk1zNFvUJhP
         IxpUkrJVeSE6T0D3oQzsFsvCrVV7RV8ZlbP4+ZW98RHzaWTJTUg/gdN3z7JYXliwY8
         Smi676PBEx5wEYAZZzsSVruBCi3LUf3SA0e0TPnqvKhsYiYp97YI1uAfW+ruJgP7dI
         XEfAPaQAmH3bbYofYJnmkvk7peaQ7oMlrwy7Ms1i3Et7FLBiMwWAzVeyWL09r9hZ0l
         ywHMyLdVPn6zw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 11 Dec 2023 13:08:55 +0000
Subject: [PATCH RESEND v3] KVM: selftests: Initialise dynamically allocated
 configuration names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231211-kvm-get-reg-list-str-init-v3-1-6554c71c77b1@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eN+xX6DmUW4iySUtNTiONSvtkTg9S6O6PBUBb147Eow=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBldwo35IUcY6oNTJ2v6bW/nJJU3aNtV6hPHyuPoXmM
 jPdqsNCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXcKNwAKCRAk1otyXVSH0IF/B/
 0c7d7J486YSDJ+Oc8P2P4naqawpIeasFieXQgYjUPg9+qbMhD+8uicOI6zb+yfZu4r1g5Vln7DxbBT
 ZWGKK9OseW5cEGQwReDbJJxilNJ7IbG/mSdEhcPS/bd70N+504CuCHzw+Tk+F91kA1+hIniVchID9Z
 o2pz9kM6OAYVGfnChlqKblwrnBM+43eroWz+YGd3WCWVO92NrulsrbRR0NG+fzRXk/sdwJQwFNMRvl
 evQcp1xUfIrtBCI2uYrwmjE283O1pZA/rcZFbN55/JkWqO9F0eTgEeKaRSRqws4ckEn74L8C7Wbr4r
 2+azED66yUak8FbJi2v6luHBgrNdlo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we dynamically generate a name for a configuration in get-reg-list
we use strcat() to append to a buffer allocated using malloc() but we
never initialise that buffer. Since malloc() offers no guarantees
regarding the contents of the memory it returns this can lead to us
corrupting, and likely overflowing, the buffer:

  vregs: PASS
  vregs+pmu: PASS
  sve: PASS
  sve+pmu: PASS
  vregs+pauth_address+pauth_generic: PASS
  X�vr+gspauth_addre+spauth_generi+pmu: PASS

Initialise the buffer to an empty string to avoid this.

Fixes: 2f9ace5d4557 ("KVM: arm64: selftests: get-reg-list: Introduce vcpu configs")
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase this bugfix onto v6.7-rc1
- Link to v2: https://lore.kernel.org/r/20231017-kvm-get-reg-list-str-init-v2-1-ee30b1df3e50@kernel.org

Changes in v2:
- Update Fixes: tag.
- Link to v1: https://lore.kernel.org/r/20231013-kvm-get-reg-list-str-init-v1-1-034f370ff8ab@kernel.org
---
 tools/testing/selftests/kvm/get-reg-list.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index be7bf5224434..dd62a6976c0d 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -67,6 +67,7 @@ static const char *config_name(struct vcpu_reg_list *c)
 
 	c->name = malloc(len);
 
+	c->name[0] = '\0';
 	len = 0;
 	for_each_sublist(c, s) {
 		if (!strcmp(s->name, "base"))

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231012-kvm-get-reg-list-str-init-76c8ed4e19d6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

