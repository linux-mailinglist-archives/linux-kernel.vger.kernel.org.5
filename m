Return-Path: <linux-kernel+bounces-47402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41D844D8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8A1B2D9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CEA3EA9B;
	Wed, 31 Jan 2024 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nE6k6GwO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C43BB29
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745380; cv=none; b=XK9FbRp6VWzLNFvnapMu9ZonOztMWaydFh0X1MxMLdiz8TCSExohGSWaVRFSQQpJQveQmztvvxIlk0Du3R7d1POHu42PA0cSV6JUqmxssy4Nzn11aKvF83rTA/K7bI+QveS7ajEjFF7Cq2tsA/KmyR1Tjf8YWF7YU32s/2wR5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745380; c=relaxed/simple;
	bh=Y2eTrWyIvoI9BY4Vorbbz847bJmJSiZQnQACclMHzyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=osB5s5z9ZqaGOL0C2iGLZ6sCL3CTKYb5G9UJoRYwtu4GGGMG2RVfiI4kOfgce2L5gVNvPiShNuGU1RxtH448dA+sJHRG2kezbGNiSCs/Bh/UCu0jiirON+iSreji2YdP9ZUyPccqLnLg5/ax+PBl+yPCcroB56F3awVn6zugaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nE6k6GwO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040597d005so6844047b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706745375; x=1707350175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wDrpEbS6CmtfJ+E5uJL5CN/JlvMOfJl9phijYT5xNg4=;
        b=nE6k6GwOgPbzqBzDgNDXdpItFoEceXrLJfmpvHlwcgPlaUbtKdpXDQIZbJkpbJ8XN3
         YQlCPCTG49J0ezo4eRtgwoplBXIgraqjEuogEM3OgshhL6XRok1l3lxP4ssI6pcF0jWA
         A4TAD/fV0uJ2mhwU61jYzyU3vt0XMy2H7Zez8nmR7AUsXycLTttGvyrNd+B8YPQ64nvb
         XpdM6zlwXClEJlVlrCwYeGgzZ9DZQwIeWKEyXI4YPsqn8G86B6ilsOjetPE7zbR1Ug6K
         2zFRg1EkP/oXdeppVZan34sZ5Uy9ohgNVVFIDNPIdwVFABl7gBJywozQ7lki4uk8ybMh
         2XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706745375; x=1707350175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDrpEbS6CmtfJ+E5uJL5CN/JlvMOfJl9phijYT5xNg4=;
        b=sfI3ptrBa2WtwlTKjH9Ic1EmLYOdfD5irPOkiXPQ/H19tbnsUIqTvgB7iWW9GuuLws
         68jKKSnLAmRN1q8daoWP9/XB9FOlTYebzOaMCrhWtxRzvE8T47RAG2rghg0As1KTW8RH
         Owv9o3u8KSBdXVU8/mgVpt7PSZCMdnMNlWOjwdc2n11ERzRz6eKaOgFbxyhRDl7xGSUw
         smX1B7GFFE3gUdSIB7trB6Bq0TACA/d2Z3drGLnLco3SfyX09ewN0KvdZBWlR5McO+5K
         QG/iFJ+LKUVhM6CVa9/ANRwd4M0VHife+5yZCrmNKJN3Ps26IhSskg7e6GB1Kdxdfw88
         OHHA==
X-Gm-Message-State: AOJu0YzgCRqdd7EgDs/eocBPMfy4Ezc+QDS4nupVymLF9eSjQsKIJjkj
	qJaFJVh8RtCb997FG/A/VsmYHl0tiYd7Vgto8yX8G2amcA8jRCU3biqpr9QdrZSveNSBDMb+BuT
	kBA==
X-Google-Smtp-Source: AGHT+IGbEnNEURC9jLZidxPUnwtX4/73UpoOEZWNy8Mqhjwh4iVtL4GbanNwrnNPMoZFVk33EXFFZMNkdNI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:9e:b0:603:ea10:c37c with SMTP id
 be30-20020a05690c009e00b00603ea10c37cmr719982ywb.7.1706745375516; Wed, 31 Jan
 2024 15:56:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 31 Jan 2024 15:56:07 -0800
In-Reply-To: <20240131235609.4161407-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240131235609.4161407-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131235609.4161407-3-seanjc@google.com>
Subject: [PATCH v4 2/4] KVM: SVM: Use unsigned integers when dealing with ASIDs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Convert all local ASID variables and parameters throughout the SEV code
from signed integers to unsigned integers.  As ASIDs are fundamentally
unsigned values, and the global min/max variables are appropriately
unsigned integers, too.

Functionally, this is a glorified nop as KVM guarantees min_sev_asid is
non-zero, and no CPU supports -1u as the _only_ asid, i.e. the signed vs.
unsigned goof won't cause problems in practice.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 18 ++++++++++--------
 arch/x86/kvm/trace.h   | 10 +++++-----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7c000088bca6..04c4c14473fd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -84,9 +84,10 @@ struct enc_region {
 };
 
 /* Called with the sev_bitmap_lock held, or on shutdown  */
-static int sev_flush_asids(int min_asid, int max_asid)
+static int sev_flush_asids(unsigned int min_asid, unsigned int max_asid)
 {
-	int ret, asid, error = 0;
+	int ret, error = 0;
+	unsigned int asid;
 
 	/* Check if there are any ASIDs to reclaim before performing a flush */
 	asid = find_next_bit(sev_reclaim_asid_bitmap, nr_asids, min_asid);
@@ -116,7 +117,7 @@ static inline bool is_mirroring_enc_context(struct kvm *kvm)
 }
 
 /* Must be called with the sev_bitmap_lock held */
-static bool __sev_recycle_asids(int min_asid, int max_asid)
+static bool __sev_recycle_asids(unsigned int min_asid, unsigned int max_asid)
 {
 	if (sev_flush_asids(min_asid, max_asid))
 		return false;
@@ -143,8 +144,9 @@ static void sev_misc_cg_uncharge(struct kvm_sev_info *sev)
 
 static int sev_asid_new(struct kvm_sev_info *sev)
 {
-	int asid, min_asid, max_asid, ret;
+	unsigned int asid, min_asid, max_asid;
 	bool retry = true;
+	int ret;
 
 	WARN_ON(sev->misc_cg);
 	sev->misc_cg = get_current_misc_cg();
@@ -188,7 +190,7 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 	return ret;
 }
 
-static int sev_get_asid(struct kvm *kvm)
+static unsigned int sev_get_asid(struct kvm *kvm)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
@@ -284,8 +286,8 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_bind_asid(struct kvm *kvm, unsigned int handle, int *error)
 {
+	unsigned int asid = sev_get_asid(kvm);
 	struct sev_data_activate activate;
-	int asid = sev_get_asid(kvm);
 	int ret;
 
 	/* activate ASID on the given handle */
@@ -2312,7 +2314,7 @@ int sev_cpu_init(struct svm_cpu_data *sd)
  */
 static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va)
 {
-	int asid = to_kvm_svm(vcpu->kvm)->sev_info.asid;
+	unsigned int asid = to_kvm_svm(vcpu->kvm)->sev_info.asid;
 
 	/*
 	 * Note!  The address must be a kernel address, as regular page walk
@@ -2630,7 +2632,7 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 void pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-	int asid = sev_get_asid(svm->vcpu.kvm);
+	unsigned int asid = sev_get_asid(svm->vcpu.kvm);
 
 	/* Assign the asid allocated with this SEV guest */
 	svm->asid = asid;
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 83843379813e..b82e6ed4f024 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -732,13 +732,13 @@ TRACE_EVENT(kvm_nested_intr_vmexit,
  * Tracepoint for nested #vmexit because of interrupt pending
  */
 TRACE_EVENT(kvm_invlpga,
-	    TP_PROTO(__u64 rip, int asid, u64 address),
+	    TP_PROTO(__u64 rip, unsigned int asid, u64 address),
 	    TP_ARGS(rip, asid, address),
 
 	TP_STRUCT__entry(
-		__field(	__u64,	rip	)
-		__field(	int,	asid	)
-		__field(	__u64,	address	)
+		__field(	__u64,		rip	)
+		__field(	unsigned int,	asid	)
+		__field(	__u64,		address	)
 	),
 
 	TP_fast_assign(
@@ -747,7 +747,7 @@ TRACE_EVENT(kvm_invlpga,
 		__entry->address	=	address;
 	),
 
-	TP_printk("rip: 0x%016llx asid: %d address: 0x%016llx",
+	TP_printk("rip: 0x%016llx asid: %u address: 0x%016llx",
 		  __entry->rip, __entry->asid, __entry->address)
 );
 
-- 
2.43.0.429.g432eaa2c6b-goog


