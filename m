Return-Path: <linux-kernel+bounces-73227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56C85BF94
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D655F1F21D89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59017768F8;
	Tue, 20 Feb 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeB/23qB"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4176415
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441909; cv=none; b=rsYbg5IQPaqzKDcw3b/NXH5/sGanjySuM2mawQyHnKS3I8oAhM6AR9qW8b1OvoMTgVn/aUgCLhg3Lku7CizYJzuuJYwuI0sRp/0hDq2xiW0kDI3yGCylb+j8IcWVO2zqL9wnAj7E5eAmjXFLvnwdE7MthzPKZcijOFLJjKkCWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441909; c=relaxed/simple;
	bh=iAbfp5RMm6S0VsTLeL0qLihHKZbBLamOM0a8x66sOYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qe6wi1L7P14TOowR6ZHzfYQFBE1uN6ixvAblIoTDhH7nh48lQaFivwhytnCMk0dtvUYuziQZ4GTE4s8tDcwDY93RXVpj87Jkm81VlBziWD6F5GaLHzZtMZFwePXpxN+4lCh5Bp6bJs5S53QC312ggDtspky04tHnvW1EGcEaeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeB/23qB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40f01cf71ceso32331395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708441906; x=1709046706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7oP8Hepk3ownDnPLORI/cfTnoWlrJNhVmX40NRmmOs=;
        b=SeB/23qBiLQHIBwyrSbXj4AWgF3imIC5u4XC3L4VZjuNXwlzggVXLl0n9FvmRH0ALC
         WJpeQIfqU45qhciXLALfD7O8mwOkM2mQygj1QrTTYNQTtKt6XUSI6tVeocrCZCmMVj4m
         1LhJDDTxL+KMmkIG/ndedDTfMdWUuKwgPu15M7ovN/7RPpgXeBwbw8DtoQ7B6ILA7BZE
         pym8pIgq+9sQKJJK6Dy3A0BMd2vZaHcO+OsOcGRRu+tDuQNmicsHT+wF06hE93UYIi94
         irlp7VjGU5l10dAvKXrkA6+JWO2qOlIrEHc0fJgR2DqPOAjF1n0ojaLuwI+Lls5Uiot2
         nHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441906; x=1709046706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7oP8Hepk3ownDnPLORI/cfTnoWlrJNhVmX40NRmmOs=;
        b=v+IVTmH03VPMLZLsSQLI8/Yyw2V7KRqQ1i92wTBdBonuiBPR35YDj1MiB40jp0yQEk
         uq8H6/kn6wXHVQqvbDOn/60N95Yu8ANwEgLSLA8RPNpgxhiMeyiblbCdg5/jhZifU1zj
         ZSm/vUnHWJ2Zj1EsbusBOCNEgFiP25hgRVOSQ1saY+x/taAruLjtWooYoixLiT41qHN8
         XILxGwW+Tm//D073SasfZtLGt4L5GRHD+d01/gtw34Yr39CpKD09Qg8IwAD9DHDisOKG
         n9CWjqV+//S4ajr/bDfR/NplktoRcNbIpiIfgAP/LilBi+Ann1Uq2eDNrMCrhfkBmYFb
         wwAw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQEHhgqJGvHFeO8fw83M4lGOeNWm4zZylUfBbvei6YdmrbcBrz5X1gfcgrreco4hjgu2AM4NPiob4JJZDKz92PZgISvDN+imHHmNx
X-Gm-Message-State: AOJu0YwNYNiU2+okfiJkz+JBqNfZt1ikt53UjAZoEUGlimDqOhsQ7tSw
	Z88VEq+ZRI1ufxNd2TuH/vpuuMAXIF4NU6tk7Yyb+Vg8H75tsS7UDHJkVIQVLDpNH3YXokxEXWj
	+c0JzDxE1LUQCDL6HNcyfPkpgeA==
X-Google-Smtp-Source: AGHT+IGB7BTGnDb3ZkCnAAs2rfcGHOBnu1LEeWRHD3gtXF/mQBI/OcbxgBVpxOTVwd/bVPF2OExz8lYc9i55R+XvxE0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:a:b0:411:ea5e:6142 with SMTP
 id g10-20020a05600c000a00b00411ea5e6142mr115684wmc.2.1708441906396; Tue, 20
 Feb 2024 07:11:46 -0800 (PST)
Date: Tue, 20 Feb 2024 15:10:35 +0000
In-Reply-To: <20240220151035.327199-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220151035.327199-1-sebastianene@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220151035.327199-7-sebastianene@google.com>
Subject: [PATCH v6 6/6] KVM: arm64: Expose guest stage-2 pagetable config to debugfs
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com, 
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev, 
	rananta@google.com, ricarkol@google.com, ryan.roberts@arm.com, 
	shahuang@redhat.com, suzuki.poulose@arm.com, will@kernel.org, 
	yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Make the start level and the IPA bits properties available in the
virtual machine debugfs directory. Make sure that the KVM structure
doesn't disappear behind our back and keep a reference to the KVM struct
while these files are opened.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/ptdump.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 2c4e0c122d23..a68a22592e97 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -213,8 +213,58 @@ static const struct file_operations kvm_ptdump_guest_fops = {
 	.release	= kvm_ptdump_guest_close,
 };
 
+static int kvm_pgtable_debugfs_show(struct seq_file *m, void *)
+{
+	const struct file *file = m->file;
+	struct kvm_pgtable *pgtable = m->private;
+
+	if (!strcmp(file_dentry(file)->d_iname, "ipa_range"))
+		seq_printf(m, "%2u\n", pgtable->ia_bits);
+	else if (!strcmp(file_dentry(file)->d_iname, "stage2_levels"))
+		seq_printf(m, "%1d\n", pgtable->start_level);
+	return 0;
+}
+
+static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file)
+{
+	struct kvm *kvm = m->i_private;
+	struct kvm_s2_mmu *mmu;
+	struct kvm_pgtable *pgtable;
+	int ret;
+
+	if (!kvm_get_kvm_safe(kvm))
+		return -ENOENT;
+
+	mmu = &kvm->arch.mmu;
+	pgtable = mmu->pgt;
+
+	ret = single_open(file, kvm_pgtable_debugfs_show, pgtable);
+	if (ret < 0)
+		kvm_put_kvm(kvm);
+	return ret;
+}
+
+static int kvm_pgtable_debugfs_close(struct inode *m, struct file *file)
+{
+	struct kvm *kvm = m->i_private;
+
+	kvm_put_kvm(kvm);
+	return single_release(m, file);
+}
+
+static const struct file_operations kvm_pgtable_debugfs_fops = {
+	.open		= kvm_pgtable_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= kvm_pgtable_debugfs_close,
+};
+
 void kvm_ptdump_guest_register(struct kvm *kvm)
 {
 	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
 			    kvm, &kvm_ptdump_guest_fops);
+	debugfs_create_file("ipa_range", 0400, kvm->debugfs_dentry, kvm,
+			    &kvm_pgtable_debugfs_fops);
+	debugfs_create_file("stage2_levels", 0400, kvm->debugfs_dentry,
+			    kvm, &kvm_pgtable_debugfs_fops);
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


