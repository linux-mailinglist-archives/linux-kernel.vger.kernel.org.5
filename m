Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCB7C73BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379549AbjJLRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjJLRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:11:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C3EB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:11:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0C7C433C7;
        Thu, 12 Oct 2023 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697130706;
        bh=VzPEcBEfGG7bzCQHi8ZBzVEsTqFFfq1QWeQDFJnhb98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0v2CP0RfbHmYUisPKN1l6Z24/UD9XgfhoxOHWW3opy3RRSJL4GIsi8wjX329XcBv
         1EIJTVRVwevDzcAJ7Av5ret0VPTmG3wY1tJWveQO+vx4ZItGiXm8z9zCLeJB/ZTQ5E
         irWltl0lVTlyMwr1gEe1odqSFk3u+sBRkRQsKX4i8StG+raljDUJ/c2RzMjneZLKqk
         z1Mf3REJ7emncLYgeTkx/fvkZZxf64UyIFaWjHtI8oVf3xnVqpNOoev/zY6ItsKXy2
         oWuR/5uJglvZNLvqjEed8Smx33QvpTZzfWebhehCt/UV9Kq5wPi5BK+wruM244nWtR
         Z+qg/0oV81Bgg==
Date:   Thu, 12 Oct 2023 10:11:44 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kaplan, David" <David.Kaplan@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231012171144.wtzcheq7x3qwpym6@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-4-david.kaplan@amd.com>
 <20231010193643.su6iqjniuxqqke6d@treble>
 <SN6PR12MB2702315F5C39E5354D63E68E94CDA@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231010204119.76i7vwecmeo6ex6d@treble>
 <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 04:10:31PM +0200, Borislav Petkov wrote:
> On Tue, Oct 10, 2023 at 01:41:19PM -0700, Josh Poimboeuf wrote:
> > Even if it's not a security hole, I'd still view it as a major BUG() as
> > it would directly contradict our understanding (and the comments above)
> > and could cause performance or other correctness issues that would
> > otherwise go unnoticed.
> > 
> > So I think an unconditional UD2 is warranted.
> 
> Before David's outlook mangles v2, lemme send it from a real mail
> client :-P.
> 
> v2 uses X86_FEATURE_ALWAYS as Josh requested.
> 
> ---
> From: David Kaplan <david.kaplan@amd.com>
> Date: Thu, 12 Oct 2023 08:52:32 -0500
> Subject: [PATCH] x86/retpoline: Ensure default return thunk isn't used at runtime
> 
> All CPU bugs that require a return thunk define a special return thunk
> to use (e.g., srso_return_thunk).  The default thunk,
> __x86_return_thunk, should never be used after apply_returns()
> completes.  Otherwise this could lead to potential speculation holes.
> 
> Enforce this by replacing this thunk with a ud2 when alternatives are
> applied.  Alternative instructions are applied after apply_returns().
> 
> The default thunk is only used during kernel boot, it is not used during
> module init since that occurs after apply_returns().
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
