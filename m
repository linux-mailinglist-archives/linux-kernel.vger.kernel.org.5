Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B77FB89E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbjK1KwC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 05:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjK1Kv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:51:59 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339F12C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:52:04 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id C734B14012E;
        Tue, 28 Nov 2023 10:52:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 6C36460016;
        Tue, 28 Nov 2023 10:52:01 +0000 (UTC)
Message-ID: <06b433109ae9fe821beccb9fd9e3c6a895452a24.camel@perches.com>
Subject: Re: [PATCH] checkpatch: don't complain on _Static_assert and
 _Generic use
From:   Joe Perches <joe@perches.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Nov 2023 02:52:00 -0800
In-Reply-To: <812f7729-1e48-bdcf-18be-c94c57f5e5f2@intel.com>
References: <20231127151847.52945-1-przemyslaw.kitszel@intel.com>
         <bfe9cc37ea78bd7833d22e5859495929cc896fa3.camel@perches.com>
         <812f7729-1e48-bdcf-18be-c94c57f5e5f2@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6C36460016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: narrkxjm1hm81zny8c3azqhxm85nd691
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/xpuVgGpqMZuu21LhGAjsDcg6LLxnjHAI=
X-HE-Tag: 1701168721-9053
X-HE-Meta: U2FsdGVkX19Fhf+ucr862WTQyPskMD89bSWD8tKm3CeHlMRmCzu9HvLvvH/nlbaEJvqpFCfKr2xal8vN9rroRGcTtx2NtIW6IVG+RcYnoiyn96HX80NMkXVRkbukRq9cet0othFcCepegGwsbjCxUF4q+NcW+fr1qNNgGmiF1VOzGjiMkVhe2wQpU6mqr2vjVzIkzEmC8SZxiw41Q8lmz0RTWrY4cnDzW4G5Id9SqM7LOj3A4n2B48uvQ5Gpm50UQW9vMNPaBy/okbAFKwbiMYzE82Jdrkmg0w/ZHikQurQiSptY+M2iCiVwPWEPRl7d9GGREJ1zlR+Ko7krl03tziYE9C7mteq4
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-28 at 11:25 +0100, Przemek Kitszel wrote:
> On 11/28/23 01:46, Joe Perches wrote:
> > On Mon, 2023-11-27 at 16:18 +0100, Przemek Kitszel wrote:
> > > Improve CamelCase recognition logic to avoid reporting on _Static_assert()
> > > and _Generic() use.
> > > 
> > > Other C keywords, such as _Bool, are intentionally omitted, as those
> > > should be rather avoided in new source code.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -5839,6 +5839,8 @@ sub process {
> > >   #CamelCase
> > >   			if ($var !~ /^$Constant$/ &&
> > >   			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
> > > +#Ignore C keywords
> > > +			    $var !~ /_Static_assert|_Generic/ &&
> > 
> > You'll need
> > 
> > 			    $var != /^(?:_Static_assert|_Generic)$/ &&
> > 
> > to avoid words that contain either
> 
> you are correct, thanks
> 
> also good to use non-capturing group :),  for

Well mostly correct minus the mindless typing of != instead of !~

