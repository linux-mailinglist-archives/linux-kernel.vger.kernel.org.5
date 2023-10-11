Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146F27C598C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346715AbjJKQuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjJKQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:49:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2E8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:49:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC2DC433C7;
        Wed, 11 Oct 2023 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697042997;
        bh=Ikfx5L6Si4W21+HXhUSpPD2tmrZxnnj0/OglFvXXRgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMAZwFePMsNpP9FoedKdy8cHPLkS5INAt4XzUU7unBLqY2hTMrY4GWwu6do8ZgqP3
         jOEyg58L9ClApIF7mPsAyLyGC/XqXqguLCZQnPbTbpkGX7SuFssyg1/u28sdxbHVLd
         FAYbXKypOrDemTS28i92ULGqeTPqCsJz77lStbP3osINIO/LmWbPijVBnT670mlGKF
         eq8eTQcr5nNXyQM0MsQzzc04Znmu6sdQ0V6j5pvAEF6j0u9LlKAVHtL/+9VLlnfceG
         ZQ0JehyzWxsagjrMQzeI/o6eGqjhhBD+kppEW83ivBhNtEKBbjkl2dHczYTo4HQ0rg
         QHWywNFjV9AiA==
Date:   Wed, 11 Oct 2023 09:49:55 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     tglx@linutronix.de, bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231011164955.mm5ipmuyf4rje5u3@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <ZSaTK5HOuCabHoEb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSaTK5HOuCabHoEb@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 05:20:59AM -0700, Breno Leitao wrote:
> On Tue, Oct 10, 2023 at 09:42:52PM -0700, Josh Poimboeuf wrote:
> > On Tue, Oct 10, 2023 at 03:30:27AM -0700, Breno Leitao wrote:
> > > +config MITIGATE_MDS
> > > +	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
> > > +	depends on CPU_SUP_INTEL
> > > +	default y
> > > +	help
> > > +	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
> > > +	  a hardware vulnerability which allows unprivileged speculative access
> > > +	  to data which is available in various CPU internal buffer. Deeper
> > > +	  technical information is available in the MDS specific x86 architecture
> > > +	  section: Documentation/arch/x86/mds.rst.
> > 
> > MITIGATE_GDS seems to be missing?
> 
> GDS is named `GDS_FORCE_MITIGATION` instead of  MITIGATE_GDS. See
> 11cf22869ea ("x86/speculation: Add Kconfig option for GDS")

Enabling/disabling GDS_FORCE_MITIGATION doesn't enable/disable the
mitigation, it just changes the default.

For consistency that option should probably be renamed to
MITIGATION_GDS_FORCE.  It should depend on MITIGATION_GDS.  If
MITIGATION_GDS is disabled, gds_mitigation should default to
GDS_MITIGATION_OFF.

e.g., something like

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..c8c879302b37 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2549,9 +2549,16 @@ config SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
-config GDS_FORCE_MITIGATION
-	bool "Force GDS Mitigation"
+config MITIGATION_GDS
+	bool" Mitigate Gather Data Sampling"
 	depends on CPU_SUP_INTEL
+	default y
+	help
+	  (Insert actual description here)
+
+config MITIGATION_GDS_FORCE
+	bool "Force GDS Mitigation"
+	depends on MITIGATION_GDS
 	default n
 	help
 	  Gather Data Sampling (GDS) is a hardware vulnerability which allows
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f081d26616ac..43ad3eee3d4c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -671,11 +671,15 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-#if IS_ENABLED(CONFIG_GDS_FORCE_MITIGATION)
+#if IS_ENABLED(CONFIG_MITIGATION_GDS)
+#if IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE)
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
 #else
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
 #endif
+#else
+static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_OFF;
+#endif
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",
