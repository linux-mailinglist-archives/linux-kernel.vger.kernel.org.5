Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F37D7C18
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZFNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZFNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:13:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49286187
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:13:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ca052ec63bso4005625ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698297198; x=1698901998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXO4N/XeBI5bwKQkWCT3uuchjAs5HEzvmOM9mACPP28=;
        b=OeLvceppW1/EYtdmtpQMQiTDp5zcEkeaPzeKtyxRWtDhXIpdajqkGnvaSgFDrqG1f4
         1ik1a6FthvUlQaA+OwwUDy1E9cqsL/ay101Brcfz0+YdcQcz1bmSVFJPmaPb6t2hAgPg
         9bXkPHpGO8l83fja5ApUP+ebWKIjs897wkogA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297198; x=1698901998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXO4N/XeBI5bwKQkWCT3uuchjAs5HEzvmOM9mACPP28=;
        b=rnkx7cydvRS8BzvMDvOjcDgrHY8xp9F6rVnT8z2GuETC5ojtcQdMdA7rfVC4gwBXaL
         vj+tP/BCYylh+Do5R/rQutenyxktI0t8kfR5Exxh5iLPgEmkvQXwkjgaDcRz0dRbTdcj
         pu4KSRSQu20PvT66cHVXZ0fmukqIfX7fG9Dnc7ggAhcsNcuF04aIUF1PVqJDIQaViltW
         XIw21W/G4DXipYYz6QvRNg35xczTfxcMbVmuj+OkREr/w5nMkHMlFkEBQHD1AHz842gY
         HufqVvS2abfAzxWrIAznVGRHXKVZIMvqCa31MSiiIZ9MG9Towj44DBQtS/lJuR2U/Hp4
         GM7g==
X-Gm-Message-State: AOJu0YxBQWuW478Y5GdnHjKQ1n/X/QZkeUwddnYHSKTr09iPUxxKptDE
        V/UFDVIka1o4v4vngYT+md7Q1g==
X-Google-Smtp-Source: AGHT+IEGALSo7AvdYoeTkOtEEN3dfVz6b/lMXoVOPaSvvwoMcA5k+EU/xafeM/XOaoEE+xZvgJNyCA==
X-Received: by 2002:a17:903:110c:b0:1c6:a0b:7b9a with SMTP id n12-20020a170903110c00b001c60a0b7b9amr20530216plh.3.1698297197671;
        Wed, 25 Oct 2023 22:13:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f228:3a07:1e7f:b38f])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001ca21c8abf7sm10079659plb.188.2023.10.25.22.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:13:17 -0700 (PDT)
Date:   Thu, 26 Oct 2023 14:13:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Anil Altinay <aaltinay@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKLM <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 0/4] apparmor: cache buffers on percpu list if there
 is lock, contention
Message-ID: <20231026051313.GA15694@google.com>
References: <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
 <Y+9aoFjrYkpFSvuE@linutronix.de>
 <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
 <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
 <CACCxZWO-+M-J_enENr7q1WDcu1U8vYFoytqJxAh=x-nuP268zA@mail.gmail.com>
 <31d6e8d6-0747-a282-746b-5c144a9970bb@canonical.com>
 <20231006041837.GA17924@google.com>
 <ffd13862-bc57-45ae-9fd0-454ee2d30fc2@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd13862-bc57-45ae-9fd0-454ee2d30fc2@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/17 02:21), John Johansen wrote:
> > > yeah, testing help is always much appreciated. I have a v4, and I am
> > > working on 3 alternate version to compare against, to help give a better
> > > sense if we can get away with simplifying or tweak the scaling.
> > > 
> > > I should be able to post them out some time tonight.
> > 
> > Hi John,
> > 
> > Did you get a chance to post v4? I may be able to give it some testing
> > on our real-life case.
> 
> sorry yes, how about a v5. That is simplified with 3 follow on patches
> that aren't strictly necessary, but some combination of them might be
> better than just the base patch, but splitting them out makes the
> individual changes easier to review.

Sorry for late reply. So I gave it a try but, apparently, our build
environment has changed quite significantly since the last time I
looked into it.

I don't see that many aa_get/put_buffer() anymore. apparmor buffer
functions are mostly called form the exec path:

	security_bprm_creds_for_exec()
	 apparmor_bprm_creds_for_exec()
	  make_vfsuid()
	   aa_get_buffer()

As for vfs_statx()->...->apparmor_inode_getattr()->aa_path_perm(),
that path is bpf_lsm_inode_getsecid() now.
