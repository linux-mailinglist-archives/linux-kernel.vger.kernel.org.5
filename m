Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365EE7F719F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbjKXKii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbjKXKif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:38:35 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 118C418E;
        Fri, 24 Nov 2023 02:38:42 -0800 (PST)
Received: from [192.168.1.150] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9DF0520B74C0;
        Fri, 24 Nov 2023 02:38:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DF0520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700822321;
        bh=bWMJQ3ZfpBF9dhvt4SiaJCZj02iWQIJde8FaEdTvYls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kTS8OY3umiZsbjaLXzS+TYMWNjoZTWuEhgX5VxebyxpORdIQBzAGdvNBibm9zcg0L
         Tu9gO03a5Wx0myK3wV7HWYmjwF1KKSt4bRrfAEnS2qTdtwncyYSccWJxTbx9m2ASa+
         n4V9wvYlV3gxxA+CwSWmzQt6JzLUSW3tN2tzy234=
Message-ID: <837fb5e9-4a35-4e49-8ec6-1fcfd5a0da30@linux.microsoft.com>
Date:   Fri, 24 Nov 2023 11:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/coco: Disable TDX module calls when TD
 partitioning is active
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org, stable@vger.kernel.org
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231122170106.270266-2-jpiotrowski@linux.microsoft.com>
 <20231123141318.rmskhl3scc2a6muw@box.shutemov.name>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231123141318.rmskhl3scc2a6muw@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 15:13, Kirill A. Shutemov wrote:
> On Wed, Nov 22, 2023 at 06:01:05PM +0100, Jeremi Piotrowski wrote:
>> Introduce CC_ATTR_TDX_MODULE_CALLS to allow code to check whether TDX module
>> calls are available. When TD partitioning is enabled, a L1 TD VMM handles most
>> TDX facilities and the kernel running as an L2 TD VM does not have access to
>> TDX module calls. The kernel still has access to TDVMCALL(0) which is forwarded
>> to the VMM for processing, which is the L1 TD VM in this case.
> 

Correction: it turns out TDVMCALL(0) is handled by L0 VMM.

> Sounds like a problem introduced by patch 1/3 :/
> 

What problem are you referring to? This patch is making the kernel aware of which
subfeatures of TDX are available to it.

This patch is needed once you make the kernel aware of X86_FEATURE_TDX_GUEST, which
is applicable because we're dealing with a TDX guest.
