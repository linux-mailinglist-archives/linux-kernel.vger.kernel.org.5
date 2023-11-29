Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69317FCC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjK2Asx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 19:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2Asw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:48:52 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706C19AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:48:57 -0800 (PST)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id BB0F0802A5;
        Wed, 29 Nov 2023 00:48:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 351D932;
        Wed, 29 Nov 2023 00:48:54 +0000 (UTC)
Message-ID: <facf6ef0c3775b02b14022a5b901eba309fd1c68.camel@perches.com>
Subject: Re: [PATCH] checkpatch: don't complain on _Static_assert and
 _Generic use
From:   Joe Perches <joe@perches.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Nov 2023 16:48:53 -0800
In-Reply-To: <812f7729-1e48-bdcf-18be-c94c57f5e5f2@intel.com>
References: <20231127151847.52945-1-przemyslaw.kitszel@intel.com>
         <bfe9cc37ea78bd7833d22e5859495929cc896fa3.camel@perches.com>
         <812f7729-1e48-bdcf-18be-c94c57f5e5f2@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 351D932
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: a69i5gtj6gnptq6socjpe5k8f97kd9uo
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/9q0i9JxMkafrMA+clavWc7x2/0YGtA/k=
X-HE-Tag: 1701218934-729647
X-HE-Meta: U2FsdGVkX1/Sxy27tJBG3cmcJmUDPbrjRV64sfBaCXiOJW8ksAx7XJrdyRbPbLFt8vRWX/IPjKNURxjYwB4l5WAFOAxHZuiCKjEP7PjEKx7JzFhU1HLa97pr9GixcEZl4YJaX58w8DtZFi7hBHjwfB+YIkHBUp6Un2c2Dunk3SKqp1cM7f1WxDRhnr4P9JeMDh+VyGTWjRck6aaqKqNTQsFc7S8+umJ5ZD82ZUrWeuVKKb3d7GHFrLK3VP4hExzA90lyhRkarSqqLm2Q68aF3jOBatYFQPn2G/jyajDu63QxTVoUnb8Rw0vVvA8U+NZv
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

Hi again.

btw:  Looks like adding _Pragma would be useful too.

$ git grep -ohP '\b_\w+' -- '*.[ch]' | \
  sort | uniq -c | sort -rn | \
  grep -P '[a-z][A-Z]|[A-Z][a-z]' | \
  head -30
    377 __Value
    206 __pH2CCmd
    152 __pTxDesc
     78 _Pragma
     54 __pRxDesc
     52 __pRxStatusDesc
     50 _Generic
     48 _Static_assert
     41 _PyUnicode_FromString
     30 _pEleStart
     29 _PyLong_FromLong
     26 _NonStandardParameter
     24 _txOff
     24 _TransportAddress
     23 _txOn
     23 _Bool
     22 _Lxx
     21 _Exx
     19 _min_uV
     18 _StateArray
     18 _NonClockInfoArray
     18 _ClockInfoArray
     16 _8Mx32
     16 _32Mx16
     16 _16Mx32
     16 _16Mx16
     15 _REGIc
     13 _step_uV
     13 _Set_Drv_Extra
     13 __PageMovable

