Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218E3776BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjHIWDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjHIWDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:03:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC098A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691618614; x=1723154614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c82A1SQt+cKENQbWxteRTGRBJzYq26IWR+UNEDJxSp8=;
  b=Jk1JvWKmKUbcxhFS933A5j4/WhjFpKnV46YUEt8xp2tsRtvEFAwqtrv3
   iPlx8p46s2+xvjI/0oAOtIR8kspLkBmTkq9AygnbfsuUUih2Z3K8rR1V8
   KLLJ9PhVteOfKxCJAWKlzTs46ISZOxcTwGAwl7pmwURsQ6L4bHKsrSzPw
   Lr4KRt1ZEx7Tn81+f/Knzx6EWV813bJ6LjtaIGHIHo/GV5TIdonANLpn0
   0s/QSDuqojiikdFwtvtZpYr55IAUDC1roUiTCyE76EcyYGiUi52IH3ss7
   m3+nQac1H1KFZKFISJAfeJfugEB2IDdO4fSnD7rW1TSuO+Ic0yHBvbJ7F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350819525"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="350819525"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="725549357"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="725549357"
Received: from brentchi-mobl.amr.corp.intel.com (HELO desk) ([10.212.254.92])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:03:32 -0700
Date:   Wed, 9 Aug 2023 15:03:17 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Documentation/srso: Document IBPB aspect and fix
 formatting
Message-ID: <20230809220317.7qpxfkcskprt4mtf@desk>
References: <20230809102700.29449-1-bp@alien8.de>
 <20230809102700.29449-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809102700.29449-4-bp@alien8.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:27:00PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add a note about the dependency of the User->User mitigation on the
> previous Spectre v2 IBPB selection.
> 
> Make the layout moar pretty.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/admin-guide/hw-vuln/srso.rst | 71 ++++++++++++++--------
>  1 file changed, 44 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
> index 32eb5e6db272..af59a9395662 100644
> --- a/Documentation/admin-guide/hw-vuln/srso.rst
> +++ b/Documentation/admin-guide/hw-vuln/srso.rst
> @@ -42,42 +42,59 @@ The sysfs file showing SRSO mitigation status is:
>  
>  The possible values in this file are:
>  
> - - 'Not affected'               The processor is not vulnerable
> + * 'Not affected':
>  
> - - 'Vulnerable: no microcode'   The processor is vulnerable, no
> -                                microcode extending IBPB functionality
> -                                to address the vulnerability has been
> -                                applied.
> +   The processor is not vulnerable
>  
> - - 'Mitigation: microcode'      Extended IBPB functionality microcode
> -                                patch has been applied. It does not
> -                                address User->Kernel and Guest->Host
> -                                transitions protection but it does
> -                                address User->User and VM->VM attack
> -                                vectors.
> + * 'Vulnerable: no microcode':

All other mitigations capitalizes the first letter, to be consistent
s/no microcode/No microcode/

> -                                (spec_rstack_overflow=microcode)
> +   The processor is vulnerable, no microcode extending IBPB
> +   functionality to address the vulnerability has been applied.
>  
> - - 'Mitigation: safe RET'       Software-only mitigation. It complements
> -                                the extended IBPB microcode patch
> -                                functionality by addressing User->Kernel 
> -                                and Guest->Host transitions protection.
> + * 'Mitigation: microcode':

Ditto.
