Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CCC7EBCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjKOFjB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 00:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOFjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:39:00 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78280D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:38:56 -0800 (PST)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id AA08BB5DB9;
        Wed, 15 Nov 2023 05:38:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id C817E20027;
        Wed, 15 Nov 2023 05:38:51 +0000 (UTC)
Message-ID: <918c3ff64f352427731104c5275786c815b860d9.camel@perches.com>
Subject: Re: [PATCH] kasan: default to inline instrumentation
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Paul =?ISO-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@tum.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Date:   Tue, 14 Nov 2023 21:38:50 -0800
In-Reply-To: <20231114151128.929a688ad48cd06781beb6e5@linux-foundation.org>
References: <20231109155101.186028-1-paul.heidekrueger@tum.de>
         <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
         <CANpmjNNQP5A0Yzv-pSCZyJ3cqEXGRc3x7uzFOxdsVREkHmRjWQ@mail.gmail.com>
         <20231114151128.929a688ad48cd06781beb6e5@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: C817E20027
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: ci149tmxg7ynwwbqxitaxzaddtdefgft
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+fwTSWmNgrcNTJZaKLozXEV3IPMeeU9UY=
X-HE-Tag: 1700026731-843050
X-HE-Meta: U2FsdGVkX1+caAPtzwnqvBR+2LKczFrolduz4aRhs8OeGmb8crQA/jnrIxMEPLomnp/ciubtECf+tC0J9Hxkm5F65pHJzKaur0uu+wBM+bWZJWfZUTIKBXJaLp48fS6vmPxp6yOXzRFGV3H7fVgUiVXn+qPW/Lzz3w/e1hkJTjt52NSDxv/G5fh8SlnVZ/6nUfhgpdM4NQtcfGAyZSY5NSkgD+3L+gHyxjarU/SnEdjGngkUhZVftUMqElPxTv/ckJ52HpE3mkDMlVznP7NmAV9H08tkU8WXSVkWKZpMMZgmBtg009HHH3X8Dk9HlM901TYzxcHzi9i4pOn2VYo7KC7SETZOTMTbg7HqmNDgOWgsFlBYifaImDPmxDCyv2i6cjI8NQuwt9FsughtfFgAY/QAssjf5JW1fv5PIsKE3tOHACYWhuIzGLRklExWgtv+VuKvxmGxrYW71SmqK0JMDw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-14 at 15:11 -0800, Andrew Morton wrote:
> On Tue, 14 Nov 2023 12:00:49 +0100 Marco Elver <elver@google.com> wrote:
> 
> > +Cc Andrew (get_maintainers.pl doesn't add Andrew automatically for
> > KASAN sources in lib/)
> 
> Did I do this right?
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: MAINTAINERS: add Andrew Morton for lib/*
> Date: Tue Nov 14 03:02:04 PM PST 2023
> 
> Add myself as the fallthough maintainer for material under lib/
> 
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  MAINTAINERS |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/MAINTAINERS~a
> +++ a/MAINTAINERS
> @@ -12209,6 +12209,13 @@ F:	include/linux/nd.h
>  F:	include/uapi/linux/ndctl.h
>  F:	tools/testing/nvdimm/
>  
> +LIBRARY CODE
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Supported

Dunno.

There are a lot of already specifically maintained or
supported files in lib/

Maybe be a reviewer?

