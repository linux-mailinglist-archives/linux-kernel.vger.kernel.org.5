Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFE75BB79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGUAY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUAY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:24:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C6269F;
        Thu, 20 Jul 2023 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689899095; x=1721435095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ltiTaZD8fvQLVG6G9aRkD/6VXMdG8iXlqJt3UX6SgNE=;
  b=Ayb5PzP3AEmomlJ4PHrjBwwpK0ic33iTY4N0kra7IiP60RoFMcC+rtgt
   QxVE4incv94DDetki0FhkD5OluO5pAf8FvzvZBoaNX1SYqoG8vTOpnIiW
   3swj3gU0tIEdDdQE4NX2XVa/1rYaMN+HrfJBF9jCzaEnJ0nlDtWiAzf85
   NvQf0HYbumYFWXikNgqdERnvJOhbDqh5isjxfVRaTim7IbY+szwZHfkwC
   HSxVVIgrENJcTaH0/6u4QLhi6PzD4cHhMH4D40rEAk1nk8bIICxxNj3dy
   1sQLzUT4eVlQ1gnl3sYhOtSGjK2HueIXlSzOh2YGVtXfCgJPLdrD8zdEv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="365796452"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="365796452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 17:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971239414"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="971239414"
Received: from tholtx-mobl.amr.corp.intel.com (HELO [10.209.39.44]) ([10.209.39.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 17:24:54 -0700
Message-ID: <da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com>
Date:   Thu, 20 Jul 2023 17:24:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] selftests/sgx: Harden test enclave
Content-Language: en-US
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230720221623.9530-1-jo.vanbulck@cs.kuleuven.be>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230720221623.9530-1-jo.vanbulck@cs.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 15:16, Jo Van Bulck wrote:
> While I understand that the bare-metal Intel SGX selftest enclave is
> certainly not intended as a full-featured independent production runtime,
> it has been noted on this mailing list before that "people are likely to
> copy this code for their own enclaves" and that it provides a "great
> starting point if you want to do things from scratch" [1].

I wholeheartedly agree with the desire to spin up enclaves without the
overhead or complexity of the SDK.  I think I'm the one that asked for
this test enclave in the first place.  There *IS* a gap here.  Those who
care about SGX would be wise to close this gap in _some_ way.

But I don't think the kernel should be the place this is done.  The
kernel should not be hosting a real-world (userspace) SGX reference
implementation.

I'd fully support if you'd like to take the selftest code, fork it, and
maintain it.  The SGX ecosystem would be better off if such a project
existed.  If I can help here in some way like (trying to) release the
SGX selftest under a different license, please let me know.

The only patches I want for the kernel are to make the test enclave more
*obviously* insecure.

So, it's a NAK from me for this series.  I won't support merging this
into the kernel.  But at the same time, I'm very sympathetic to your
cause, and I do appreciate your effort here.
