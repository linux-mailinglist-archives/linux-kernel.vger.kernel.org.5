Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D017BA8DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJESP0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 14:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjJESPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:15:05 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866993
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:15:04 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 72A5980373;
        Thu,  5 Oct 2023 18:15:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 6556F40;
        Thu,  5 Oct 2023 18:15:01 +0000 (UTC)
Message-ID: <6e13b9b1a964b49079a2f7814c0d65e767cd010a.camel@perches.com>
Subject: Re: [PATCH] get_maintainer/MAINTAINERS: confine K content matching
 to patches
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 05 Oct 2023 11:15:00 -0700
In-Reply-To: <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com>
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
         <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
         <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6556F40
X-Stat-Signature: uxrsus4ujso7hf9ozd1j758h3wyqrsdm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+hGAfpLA1BmrpRYXbG0ILR/KpWsgTyOAk=
X-HE-Tag: 1696529701-165331
X-HE-Meta: U2FsdGVkX19zkLF8srkeZSnWC0jmIG2JreFugro4oHuh6UvV3v8NVDt++hGLmumtHQwm07jsPYm/QSzkYZckQiz81Ybfqm5MCe6J36QeG3ZHeceZ+CiyydYuEJiWujF33lzd60tODI3a85dnNpccjgjegtEJo736j34RAsbs2i34X0eY4xMIw8/H5kj68s58kA7Z1KNWoKY/k3RfZYgwsHD5Otamh1LT+pSnkqA1vqZa2C5aV9x8MXraNVpDecmSO7wxL/FzKbzDZJYJBM/Vvklt4SmNhFtk1+kgAFJEq9OXlQec4PUlaZSsg5RMood5tLAFeIqZM/UOo4mp4HceD8p+WozVot9uPuUfRk40uNKqYiHuAUyZi7YtFzx8H0uk
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-05 at 11:06 -0700, Justin Stitt wrote:
> On Wed, Oct 4, 2023 at 7:40 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> > > The current behavior of K: is a tad bit noisy. It matches against the
> > > entire contents of files instead of just against the contents of a
> > > patch.
> > > 
> > > This means that a patch with a single character change (fixing a typo or
> > > whitespace or something) would still to/cc maintainers and lists if the
> > > affected file matched against the regex pattern given in K:. For
> > > example, if a file has the word "clang" in it then every single patch
> > > touching that file will to/cc Nick, Nathan and some lists.
> > > 
> > > Let's change this behavior to only content match against patches
> > > (subjects, message, diff) as this is what most people expect the
> > > behavior already is. Most users of "K:" would prefer patch-only content
> > > matching. If this is not the case let's add a new matching type as
> > > proposed in [1].
> > 
> > I'm glad to know  you are coming around to my suggestion.
> :)
> 
> > 
> > I believe the file-based keyword matching should _not_ be
> > removed and the option should be added for it like I suggested.
> 
> Having a command line flag allowing get_maintainer.pl
> users to decide the behavior of K: is weird to me. If I'm a maintainer setting
> my K: in MAINTAINERS I want some sort of consistent behavior. Some
> patches will start hitting mailing list that DO have keywords in the patch
> and others, confusingly, not.

Not true.

If a patch contains a keyword match, get_maintainers will _always_
show the K: keyword maintainers unless --nokeywords is specified
on the command line.

If a file contains a keyword match, it'll only show the K:
keyword  if --keywords-in-file is set.

> To note, we get some speed-up here as pattern matching a patch that
> touches lots of files would result in searching all of them in their
> entirety. Just removing this behavior _might_ have a measurable
> speed-up for patch series touching dozens of files.

Again, not true.

Patches do _not_ scan the original modified files for keyword matches.
Only the patch itself is scanned.  That's the current behavior as well.

