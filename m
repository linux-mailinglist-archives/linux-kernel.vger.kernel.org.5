Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F178F45C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347475AbjHaVE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjHaVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:04:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F61107
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:04:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so928078b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693515865; x=1694120665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Au0jgTnYViUt48nP33xg4Wv/ENS84whOnKL1Ii65ne8=;
        b=m7SDyVc98Hy6ESiQ5HvA1QbD2JryQ2IGfyLRfCEQKwF9Ph92R67XbWjKRjQLaDF5Nz
         NWOhgIm42Fi9BSaf7r2MeQOwUHumv4AOS6PqftBE9umRUDYJylNfajN1JJbgK1GfotDm
         YvdHL6E53KXsQBOh6ggSfSALK9TaNj3tGwpgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515865; x=1694120665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Au0jgTnYViUt48nP33xg4Wv/ENS84whOnKL1Ii65ne8=;
        b=Vm+oetkQiBYUqt/Je0lOLBrbmZcn1POGljtL4LsqG3sPQGJwOWjzGak+dmzDmloE+e
         PmmUKTvRu7hjCIWEpJMlpcjGLEUe4euNqQ1n0ODfN268J8fI1CjPv1V6oZalhS0B6kZm
         c0nyx3DDoMJ7RfU88Xyz/mdrPU/fkvOIt8C6WGulfQZGotWbqleH3okr48ZVvN+iiz0m
         WD4z/q546KsYwRHyuGpDPjlGg3ZFXls2rhdmRAY1jxlNpx6MNptcqNyzQbF+jCev3Fx8
         OQvfES6BzLR7OCvHDBUfzyFEkBxEBSicfk/qXgFOXD07RWaaT1gDrA4xGlxtiMrEKd4c
         EupQ==
X-Gm-Message-State: AOJu0YwLDSqKSp8LL1hDIW9ZhQMAYUPtwoTNeUfqNFBYOimCN7vo7FFt
        D1GaPkPf8C7ePfewFKt5GTuE9Q==
X-Google-Smtp-Source: AGHT+IE56n0HSk12PcsENSTVStpscxK4S0XAvFr+WwpnxiMN/kNJiePa06E8oRKJ3jPlRjZDRhOuTw==
X-Received: by 2002:a05:6a20:431d:b0:12e:cbce:444a with SMTP id h29-20020a056a20431d00b0012ecbce444amr1025931pzk.37.1693515865597;
        Thu, 31 Aug 2023 14:04:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a637507000000b00570574feda0sm1686351pgc.19.2023.08.31.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:04:25 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:04:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-hardening@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/2] ocfs2: Replace strlcpy with strscpy
Message-ID: <202308311402.57CF455D55@keescook>
References: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
 <20230830215426.4181755-3-azeemshaikh38@gmail.com>
 <202308301601.8A8EE6B653@keescook>
 <CADmuW3Wc7fzoCcif7WmY4X4FWErFc4poMOqzMXu=3mf0ycju1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3Wc7fzoCcif7WmY4X4FWErFc4poMOqzMXu=3mf0ycju1Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:28:32PM -0400, Azeem Shaikh wrote:
> On Wed, Aug 30, 2023 at 7:06 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Aug 30, 2023 at 09:54:26PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > >
> > > Direct replacement is assumed to be safe here since
> > > it's ok for `kernel_param_ops.get()` to return -errno [3].
> > > This changes the behavior such that instead of silently ignoring the
> > > case when sizeof(@buffer) < DLMFS_CAPABILITIES, we now return error.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > > [3] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L52
> > >
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > > ---
> > >  fs/ocfs2/dlmfs/dlmfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> > > index 33e529de93b2..b001eccdd2f3 100644
> > > --- a/fs/ocfs2/dlmfs/dlmfs.c
> > > +++ b/fs/ocfs2/dlmfs/dlmfs.c
> > > @@ -80,7 +80,7 @@ static int param_set_dlmfs_capabilities(const char *val,
> > >  static int param_get_dlmfs_capabilities(char *buffer,
> > >                                       const struct kernel_param *kp)
> > >  {
> > > -     return strlcpy(buffer, DLMFS_CAPABILITIES,
> > > +     return strscpy(buffer, DLMFS_CAPABILITIES,
> > >                      strlen(DLMFS_CAPABILITIES) + 1);
> > >  }
> >
> > This is another case of "accidentally correct".
> >
> >
> > param->get() is hooked here, in the sysfs "show" callback:
> >
> > static ssize_t param_attr_show(struct module_attribute *mattr,
> >                                struct module_kobject *mk, char *buf)
> > {
> >         int count;
> >         struct param_attribute *attribute = to_param_attr(mattr);
> >
> >         if (!attribute->param->ops->get)
> >                 return -EPERM;
> >
> >         kernel_param_lock(mk->mod);
> >         count = attribute->param->ops->get(buf, attribute->param);
> >         kernel_param_unlock(mk->mod);
> >         return count;
> > }
> >
> > Meaning ultimately this will show up here, if I'm reading names right:
> > /sys/module/ocfs/parameters/dlmfs_capabilities
> >
> > Anyway, the "count" being returned would be quite bad if
> > DLMFS_CAPABILITIES were dynamic and larger than PAGE_SIZE (the size of
> > the sysfs buffer).
> >
> > For this case, I would say replace strlcpy with sysfs_emit:
> >
> >         return sysfs_emit(buffer, DLMFS_CAPABILITIES);
> >
> 
> Thanks, sending out a v2 for this. Out of curiosity - why sysfs_emit?
> Is it because DLMFS_CAPABILITIES is a hard-coded string?

It's basically that sysfs_emit() Does The Right Thing for these
callbacks: it tracks the offset of the buffer and checks for buffer
overflow. (All the sysfs callback work on a page-aligned page-sized
buffer, and the API lacks any length info -- it's "understood" to be
page-sized.) So, since this is doing a string copy into what is
ultimately a sysfs buffer, it's best to use sysfs_emit().

-- 
Kees Cook
