Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7FB7A28B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbjIOUvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbjIOUv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:51:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691ED2D49
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:50:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso794412466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694811034; x=1695415834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rkiDdS/1LR9sFxtLFrJTZjeayIRFE7jynLiCCcENQ8s=;
        b=c9FhPKz+31rD/xkkdo63bX9gCAQIkN0hJxjDqprC3z/mStSS2s3ToXlDYug+Mug85d
         PdgD8mPNKyhQaylgdFp+oKbmpxSGiKnSO/twAD1jhbGqglIIiesI3Jidssecdk+4GPK0
         1BtNxazSvCJKuG/huE/Jv3lh3OOfT1kH+b/fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811034; x=1695415834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkiDdS/1LR9sFxtLFrJTZjeayIRFE7jynLiCCcENQ8s=;
        b=rSLyA6D0BQekTptLGXQNB9Rz3RcvFrxeJUD622eKmoh5MVzntv7nJQD7Z9fV0y58uX
         Dd5pzaAvH23EYWtF6H7SyNRCnpXWVwQNoRevT4KzclQpc0ZTYi2wDVrE7JOQoVmewb7K
         YbKLa7rnEPVRmt8HDvJnSEHqobu1pn4hjPe15fqm3C62SmAMaRnDAGa3onslpl/jfgTX
         eERoZfjyAhJCHzr0S34yeGAuLOUTBvI6hSMjHMlixq+jtb0IvDi2f60R0adnXiIStcGz
         M+1FThZrbrkSOmhukcQmNhMJAztkXbblFlrhFAaKnU+X93IxmrRUtYU5+/9zziE1IsbE
         wLiA==
X-Gm-Message-State: AOJu0YwQcQh5+bU1RkDeIsv65Byv9R3d8D+8Cl3PMyQtvRBsOiSJAADV
        /GpRobLjgOEryhBz4PrcBIIiBEow97yhQ6Op3hwveYPl
X-Google-Smtp-Source: AGHT+IHe2SR3ybvjqlivnS5sh15AiSzV9WDaDi2FkyEfCfW9j9TABnJbLYZTnxhH8xX70ahMcYSO+g==
X-Received: by 2002:a17:907:781a:b0:9a1:b33a:e464 with SMTP id la26-20020a170907781a00b009a1b33ae464mr4352894ejc.31.1694811034798;
        Fri, 15 Sep 2023 13:50:34 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906411300b009930308425csm2844337ejk.31.2023.09.15.13.50.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 13:50:34 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9adb9fa7200so483330466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:50:34 -0700 (PDT)
X-Received: by 2002:a17:907:3f0f:b0:9a9:9d19:b250 with SMTP id
 hq15-20020a1709073f0f00b009a99d19b250mr7061769ejc.17.1694811033687; Fri, 15
 Sep 2023 13:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230913192905.0a92bcab@gandalf.local.home> <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
 <20230915163637.77c673a6@gandalf.local.home>
In-Reply-To: <20230915163637.77c673a6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 13:50:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
Message-ID: <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 13:36, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm OK with it not going in now, but instead I'll wrap an ifdef around it
> and move it to my queue for the next merge window. I still would like to
> keep these "what's going on internally" available, as I'll ask people to
> enable them when they report an issue.

Honestly, you copied the pattern from the /proc filesystem.

The /proc filesyustem is widely used and has never had this kind of
random debugging code in mainline.

Seriously, that eventfs_file thing is not worthy of this kind of
special debug code.

That debug code seems to be approaching the same order of size as all
the code evetfs_file code itself is.

There's a point where this kind of stuff just becomes ridiculous. At
least wait until there's a *reason* to debug a simple linked list of
objects.

If you have a hard time figuring out what the eventfs entries are,
maybe you should just have made "iterate_shared" show them, and then
you could use fancy tools like "ls" to see what the heck is up in that
directory?

                 Linus
