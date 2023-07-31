Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA06769D93
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjGaRDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjGaRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:02:56 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE82103;
        Mon, 31 Jul 2023 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690822954; x=1722358954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzZeHXRLpqb1X/zrxooFFBTcwn3/wXpUCDYN5d8GPZE=;
  b=DxU+n6cmJhEHrncYgbKFuszXznCDipxDRBPH6nJ1bT9dvhMeyQPPuwD2
   sOxmT43ao3zj4cVJN4k+iSML80kuzfk8xjmxx5WsIfhR+g40bdtPjmHJa
   FGMKjtQo1b0lhCX9CnmgN/mNLifxbqViNFqdj+SylfHUONybxuFxvmcMH
   SF6Su0DfJSEbfi9QZY0b839c5CqNMap3ZTn+rNiVkXIdrBL7dLNNcGzpC
   Coi5TdZBFEW6BH5q0Q/CGTCJ7TNKYLxSS0CIAvLTr8+A4vO5uY7PdqxX7
   DHKujUfvNNCLO8oqeyeLS9x6Msp36KzGi4Y6G904IObtASzrhbRPu+r6G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367976046"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="367976046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728374611"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="728374611"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.229.233])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:02:19 -0700
Date:   Mon, 31 Jul 2023 10:02:17 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, ztarkhani@microsoft.com
Subject: Re: [PATCH 1/2] lsm: change 'target' parameter to 'const' in
 security_capget LSM hook
Message-ID: <ZMfpGXM5LlDdrENi@aschofie-mobl2>
References: <cover.1690786466.git.kamrankhadijadj@gmail.com>
 <7fd5ea487559760818af96f7c1f2c25bec515049.1690786467.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd5ea487559760818af96f7c1f2c25bec515049.1690786467.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:07:31PM +0500, Khadija Kamran wrote:
> Three LSMs register the implementations for the "capget" hook: AppArmor,
> SELinux, and the normal capability code. Looking at the function
> implementations we may observe that the first parameter "target" is not
> changing.
> 
> Mark the first argument "target" of LSM hook security_capget(...) as
> "const" since it will not be changing in the LSM hook.


The commit message may be simplified, from this:
[PATCH 1/2] lsm: change 'target' parameter to 'const' in security_capget LSM hook

to something like this:
[PATCH 1/2] lsm: Constify the target parameter in security_capget()

"Constify" is the commonly used language in git logs.
See git log --pretty=oneline --abbrev-commit | grep Constify

Alison

 --snip --

> 
