Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB988037FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjLDPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjLDPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:00:24 -0500
X-Greylist: delayed 971 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 07:00:30 PST
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52033A1;
        Mon,  4 Dec 2023 07:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:To:From;
        bh=WUrV0xv5QN/acorjWX2KEAdt2ICWDXH53A8LzaiykOI=; b=PGObTwzVoq+BOqG1Ep91FZ8Cns
        b4BQlICAoBDrcriTRLtwGT/7B00y49yoxhxbgtQpY1sdFEAq+3KW0LUBcSA7hjAYT4LyyIowtKmZo
        36MIffdrgQR8nVnXT46SMswCHjtWud8KQ5ebKdZ9//CA+RfgDcy+S8eORhiEObAQyxLM=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAAQk-00043j-TN; Mon, 04 Dec 2023 15:00:18 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAABN-00088g-Cc; Mon, 04 Dec 2023 14:44:25 +0000
From:   Paul Durrant <paul@xen.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v10 13/19] KVM: selftests / xen: map shared_info using HVA rather than GFN
Date:   Mon,  4 Dec 2023 14:43:28 +0000
Message-Id: <20231204144334.910-14-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204144334.910-1-paul@xen.org>
References: <20231204144334.910-1-paul@xen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

Using the HVA of the shared_info page is more efficient, so if the
capability (KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA) is present use that method
to do the mapping.

NOTE: Have the juggle_shinfo_state() thread map and unmap using both
      GFN and HVA, to make sure the older mechanism is not broken.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v3:
 - Re-work the juggle_shinfo_state() thread

v2:
 - New in this version.
---
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 9ec9ab60b63e..a61500ff0822 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -389,6 +389,7 @@ static int cmp_timespec(struct timespec *a, struct timespec *b)
 		return 0;
 }
 
+static struct shared_info *shinfo;
 static struct vcpu_info *vinfo;
 static struct kvm_vcpu *vcpu;
 
@@ -404,20 +405,38 @@ static void *juggle_shinfo_state(void *arg)
 {
 	struct kvm_vm *vm = (struct kvm_vm *)arg;
 
-	struct kvm_xen_hvm_attr cache_activate = {
+	struct kvm_xen_hvm_attr cache_activate_gfn = {
 		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
 		.u.shared_info.gfn = SHINFO_REGION_GPA / PAGE_SIZE
 	};
 
-	struct kvm_xen_hvm_attr cache_deactivate = {
+	struct kvm_xen_hvm_attr cache_deactivate_gfn = {
 		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
 		.u.shared_info.gfn = KVM_XEN_INVALID_GFN
 	};
 
+	struct kvm_xen_hvm_attr cache_activate_hva = {
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA,
+		.u.shared_info.hva = (unsigned long)shinfo
+	};
+
+	struct kvm_xen_hvm_attr cache_deactivate_hva = {
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
+		.u.shared_info.hva = 0
+	};
+
+	int xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
+
 	for (;;) {
-		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_activate);
-		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_deactivate);
+		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_activate_gfn);
 		pthread_testcancel();
+		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_deactivate_gfn);
+
+		if (xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA) {
+			__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_activate_hva);
+			pthread_testcancel();
+			__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_deactivate_hva);
+		}
 	}
 
 	return NULL;
@@ -442,6 +461,7 @@ int main(int argc, char *argv[])
 	bool do_runstate_flag = !!(xen_caps & KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG);
 	bool do_eventfd_tests = !!(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL);
 	bool do_evtchn_tests = do_eventfd_tests && !!(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_SEND);
+	bool has_shinfo_hva = !!(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA);
 
 	clock_gettime(CLOCK_REALTIME, &min_ts);
 
@@ -452,7 +472,7 @@ int main(int argc, char *argv[])
 				    SHINFO_REGION_GPA, SHINFO_REGION_SLOT, 3, 0);
 	virt_map(vm, SHINFO_REGION_GVA, SHINFO_REGION_GPA, 3);
 
-	struct shared_info *shinfo = addr_gpa2hva(vm, SHINFO_VADDR);
+	shinfo = addr_gpa2hva(vm, SHINFO_VADDR);
 
 	int zero_fd = open("/dev/zero", O_RDONLY);
 	TEST_ASSERT(zero_fd != -1, "Failed to open /dev/zero");
@@ -488,10 +508,16 @@ int main(int argc, char *argv[])
 			    "Failed to read back RUNSTATE_UPDATE_FLAG attr");
 	}
 
-	struct kvm_xen_hvm_attr ha = {
-		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
-		.u.shared_info.gfn = SHINFO_REGION_GPA / PAGE_SIZE,
-	};
+	struct kvm_xen_hvm_attr ha = {};
+
+	if (has_shinfo_hva) {
+		ha.type = KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA;
+		ha.u.shared_info.hva = (unsigned long)shinfo;
+	} else {
+		ha.type = KVM_XEN_ATTR_TYPE_SHARED_INFO;
+		ha.u.shared_info.gfn = SHINFO_ADDR / PAGE_SIZE;
+	}
+
 	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &ha);
 
 	/*
-- 
2.39.2

