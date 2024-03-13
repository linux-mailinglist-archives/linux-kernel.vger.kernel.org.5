Return-Path: <linux-kernel+bounces-101855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B587AC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A5B237FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D7757E9;
	Wed, 13 Mar 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je5Svtqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958F74E26;
	Wed, 13 Mar 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347892; cv=none; b=bUdw57JkS2jfFCnkjfW8WdaVIvz4ATI9QoQAkWpnIFG/ABUK5lvj495TtFFCEa//B374ORa1keCX2L1K0CAljrOd8iNIuO4HtSUx7fC37lURA70bg/CuLpdVXfi0wtTCGV8SI7tdM+FX0iKVMd8EuWHQGSt6XBXf1NvAITAGG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347892; c=relaxed/simple;
	bh=CsHzNpdG5SPYklOSqqw8wKOSpXXQqJ0UmRMBg28eU9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQJnm/7mW5DzqE51iLapXd0i+/kDoZ8+oVaALoevNAKWR7bq3MEmrk7wHELtHFVZpdj2eRB3IEUjuM3ZPYpAPPd2sp8ZyYZCV8uU+xexttoPxJusTBu13AldLoZ4CQjyz51W2GjbbmsiBGNJzLPozXfEWAa/+CPlzFZCV1sXJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je5Svtqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16215C43390;
	Wed, 13 Mar 2024 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347892;
	bh=CsHzNpdG5SPYklOSqqw8wKOSpXXQqJ0UmRMBg28eU9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=je5SvtqdoDNR8yIU+LSrdQlszXlkbVs8TG5+EKKpRqHm+0wX1cuyRO7IOVWCSRHu7
	 gcyjCtGeQ1cxHVgZhRDGL37ADyxqlaZSCdz+/9Z7R396uvNb1SjL0MIK2ZqgPJ4Cnm
	 VszfQetCd3JaxgFmlciggx+jwEQpvCAknkjGHzZ+YYIKnjKXfgMEuEuK90STMQzbUZ
	 g5GgPKtjPtyPzw9scjs5O6+vYhbeJlsiUuRj5wbXhgWe3AIHU1gc0GId+0ZKBJWt3j
	 QQ6z8KLksz/7AT2M81YR9CVIC7dj6b5KHY9fMn4P/gEUxefLaui/ZiLc3FUR/DW053
	 y0ZLeZ+kffpSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 52/60] KVM: s390: vsie: fix race during shadow creation
Date: Wed, 13 Mar 2024 12:36:59 -0400
Message-ID: <20240313163707.615000-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christian Borntraeger <borntraeger@linux.ibm.com>

[ Upstream commit fe752331d4b361d43cfd0b89534b4b2176057c32 ]

Right now it is possible to see gmap->private being zero in
kvm_s390_vsie_gmap_notifier resulting in a crash.  This is due to the
fact that we add gmap->private == kvm after creation:

static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
                               struct vsie_page *vsie_page)
{
[...]
        gmap = gmap_shadow(vcpu->arch.gmap, asce, edat);
        if (IS_ERR(gmap))
                return PTR_ERR(gmap);
        gmap->private = vcpu->kvm;

Let children inherit the private field of the parent.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Cc: <stable@vger.kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/r/20231220125317.4258-1-borntraeger@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/vsie.c | 1 -
 arch/s390/mm/gmap.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 8207a892bbe22..db9a180de65f1 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1220,7 +1220,6 @@ static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
 	gmap = gmap_shadow(vcpu->arch.gmap, asce, edat);
 	if (IS_ERR(gmap))
 		return PTR_ERR(gmap);
-	gmap->private = vcpu->kvm;
 	vcpu->kvm->stat.gmap_shadow_create++;
 	WRITE_ONCE(vsie_page->gmap, gmap);
 	return 0;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 20786f6883b29..157e0a8d5157d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1691,6 +1691,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 		return ERR_PTR(-ENOMEM);
 	new->mm = parent->mm;
 	new->parent = gmap_get(parent);
+	new->private = parent->private;
 	new->orig_asce = asce;
 	new->edat_level = edat_level;
 	new->initialized = false;
-- 
2.43.0


