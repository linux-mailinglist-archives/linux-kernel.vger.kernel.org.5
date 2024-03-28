Return-Path: <linux-kernel+bounces-123114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E382C890251
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8CF291D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54912EBD3;
	Thu, 28 Mar 2024 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClbNzDoI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA780BF8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637572; cv=none; b=INDg4sEjGumIPdF+xjpzXi9+QCwmbSseK+EdrIR0C/zDHYfyNXMIjIkWebJRLrna581QcXPaoS1yLi7IwiknKADvYh9UHoIuR9vPmr90xQD9u8MbEpZYHm+lnOfV5vpUPqXqInuFuyOzatkKEr3RfwGr+XDHD7BDzJPJPWFgeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637572; c=relaxed/simple;
	bh=wsMISnY+P939Tjf/dWnmziDkvmrKZMMPjOTpFgDCV80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=VIFbqpGh4uLwO9jCBIbfb2FaRMRTJ2jxtFrrZECPwZvVVMUSXUSXv+Hi38SYNo8ltDH2qL6y8F3Gc2Ir/muO85e73zENoNL0cqLd34a/kNuBWfHWvwf+tRcV91jyOufksGF156+73eEe4/OQ+EOlhm5ah8pkSbqwDeAAcMUJHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClbNzDoI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711637569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZC6LpnNH1Pnr/7Ya6DiyzYe2avakdySerWwdr2kSjE=;
	b=ClbNzDoI+74zOlC6SGzcv+G6x8qFYRm+CiBUzf4B2gZFo3TKERCl11xElDRzsW0rEujT90
	lrdvCQ2FmpDIrvgskfKhB6mCBH8OWZpqey608JKV9nCfApCvJ2+wNyobijxwcNpoUFNei1
	bzWwyjDgO2GzQvAyeUvniUgGM+gOedc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-hmG1-Ra4N_OxAr-8dJqrQA-1; Thu, 28 Mar 2024 10:52:48 -0400
X-MC-Unique: hmG1-Ra4N_OxAr-8dJqrQA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6986eb55527so7034896d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637567; x=1712242367;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZC6LpnNH1Pnr/7Ya6DiyzYe2avakdySerWwdr2kSjE=;
        b=X+RYnp68jfTMrixR5MnRuhq9qP0YJ/nhM7ELgpH/1yQN/onMzJ8+NcZvWX4dVofB3M
         ARtr6zbASiH7fGO2egbupVb4lTODTivMpESiX5rLt1ZwWpgisAzN48Brl/0glERMcNeQ
         BR3FV2X6V7QLuQIHEZarCfylZDGubOcjP/SXqtRFUmK7MXs6uoJVvFARMZNjkTH5CYbg
         errWVABtLwvgqJ2ezZsXwO5HtXSbYR39WPCnNDVD6/GAYlf5JRFgXbkdlSYcOQu6xL1Q
         5FvrQqMV25GLnXopfEoY81LgL9wevU2SoBAJCy2JnjdKwwUZjbx/kco+Mm8/Mv6jP+6Q
         jl9w==
X-Forwarded-Encrypted: i=1; AJvYcCV8QO2K2kxInf2uWFS0EB6mOCZOaskiQUON/rglP9q3V8ABThzaPE4oyHVyeFN/y92DvGUjsr+lw0qjvwlpvrt5o+SfLxj9NpwfkPdm
X-Gm-Message-State: AOJu0YxDxaHSk8kYaxtAGWxIbzY/3Db8YFU6goSGpXvyUVlaC1EPhgil
	9bQH/5SVjhoAa0BFW0Li/LKtsWrBzsFjd/sKLhDuV5MLPyjmSMZxKGYFugSiPiMgl7p5PlLiUm+
	2w2QYv8SJKXnuPc+gPq9Q+PG4P4ZMxNZDub+aMprNQGXxBTQOBprp8bG88hghdQ==
X-Received: by 2002:a0c:f28d:0:b0:696:17cf:d35b with SMTP id k13-20020a0cf28d000000b0069617cfd35bmr2767504qvl.2.1711637567613;
        Thu, 28 Mar 2024 07:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6VYbkZHOJjvqtGiMbdHScRQZjNOS3tNxcMDt/vTkmrVDVwnOcpTahAEHw3cPMGonrfw6KRw==
X-Received: by 2002:a0c:f28d:0:b0:696:17cf:d35b with SMTP id k13-20020a0cf28d000000b0069617cfd35bmr2767477qvl.2.1711637567168;
        Thu, 28 Mar 2024 07:52:47 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:d7ed:4b57:3fcd:d5e6:a613])
        by smtp.gmail.com with ESMTPSA id mf13-20020a0562145d8d00b006903af52cbfsm707817qvb.40.2024.03.28.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:52:46 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Helen Koike <helen.koike@collabora.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gitlab-ci: Let project define runner using environment variables
Date: Thu, 28 Mar 2024 11:52:40 -0300
Message-ID: <ZgWEOJDPl_MEupwz@LeoBras>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <c0cc12e6-4f71-449c-b614-a8fbfb4aaa80@collabora.com>
References: <20240327013055.139494-2-leobras@redhat.com> <c0cc12e6-4f71-449c-b614-a8fbfb4aaa80@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Mar 28, 2024 at 10:17:00AM -0300, Helen Koike wrote:
> Hi Leonardo,
> 
> Thanks for the patch.
> 
> On 26/03/2024 22:30, Leonardo Bras wrote:
> > Currently it's not possible to select which runner will handle a pipeline
> > without changing the codebase.
> > 
> > Add CI_TAGS environment variable, which can be used to select a runner
> > either from a commit message, or directly from Gitlab interface.
> > 
> > Also add Documentation for this variable.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> > 
> > This patch goes on top on a previous patchset sent by Helen:
> > https://lore.kernel.org/all/20240228225527.1052240-1-helen.koike@collabora.com/
> > 
> > With this patch I could run CI with gitlab.com runners, by setting
> > CI_TAGS=saas-linux-medium-amd64
> > 
> > The result of this pipeline can be seen in:
> > https://gitlab.com/linux-kernel/linux/-/pipelines/1228999646
> > 
> >   Documentation/ci/gitlab-ci/gitlab-ci.rst | 5 +++++
> >   ci/gitlab-ci/yml/gitlab-ci.yml           | 2 ++
> >   2 files changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/ci/gitlab-ci/gitlab-ci.rst b/Documentation/ci/gitlab-ci/gitlab-ci.rst
> > index 4f7ef03cca95..18360da835bd 100644
> > --- a/Documentation/ci/gitlab-ci/gitlab-ci.rst
> > +++ b/Documentation/ci/gitlab-ci/gitlab-ci.rst
> > @@ -304,20 +304,25 @@ Description of Each Variable
> >   **KCI_CHECKPATCH_OPTIONS**
> >       Used in `checkpatch.pl "$KCI_CHECKPATCH_OPTIONS"` (see checkpatch
> >       documentation). It is commonly used with the --ignore flag to suppress
> >       specific warnings generated by checkpatch.pl. It can also be defined in the
> >       commit message, since it is evaluated in run time.
> >   **KCI_PATCH_SERIES_SIZE**
> >       Used to define the size of the patch series, see `job: checkpatch` section
> >       above. It is evaluated in run time, and can be set in the commit message.
> > +**CI_TAGS**
> 
> I would just s/CI/KCI , I'm using KCI_prefix for those that are defined by
> us, since gitlab already uses CI_ prefix.

I was aware of CI_ vs KCI_ prefix, but for some reason at the time I 
decided that since this was about setting the gitlab tags, and not 
something internal to Kernel CI,  it would make more sense to use the CI_ 
prefix. 

But I have no strong opinion on this, so if you think it's better to 
call it KCI_TAGS, let's do that instead.

> 
> We will also need a way to specify tags per job at some point
> KCI_TAGS_$JOB_NAME or something, but this can be added later.

Yeah, agree.

I wish we could specify tags with running requirements for each task in 
some way, and let the gitlab instance to pick the better runner.


> 
> Acked-by: Helen Koike <helen.koike@collabora.com>
> 
> I'll add on top of my tree for now, so we can prepare v2 with this change.
> 
> Thanks
> Helen

Thank you!
Leo

> 
> > +    Used to help choose which runner will deal with the current pipeline.
> > +    If using Gitlab.com runners, set saas-linux-medium-amd64 or a better runner
> > +    so there is enough resources to build & commit the base image.
> > +
> >   .. _triggering-pipelines-from-command-line:
> >   Triggering Pipelines from Command Line
> >   --------------------------------------
> >   Pipelines can be triggered from the command line with custom variables using the
> >   `GitLab CLI tool <https://docs.gitlab.com/ee/editor_extensions/gitlab_cli>`_.
> >   Example:
> > diff --git a/ci/gitlab-ci/yml/gitlab-ci.yml b/ci/gitlab-ci/yml/gitlab-ci.yml
> > index 57b9c0290471..359b7715e3ab 100644
> > --- a/ci/gitlab-ci/yml/gitlab-ci.yml
> > +++ b/ci/gitlab-ci/yml/gitlab-ci.yml
> > @@ -33,20 +33,22 @@ workflow:
> >       - if: $FORCE_CI == 'true'
> >   variables:
> >     FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where to look for cached images
> >       # ccache builds in gitlab-runner to speed up builds
> >     SMATCH_DB_DIR: /smatch/smatch_data
> >     # exit code of bash script on `script` will be the exit code of the job
> >     FF_USE_NEW_BASH_EVAL_STRATEGY: "true"
> >   default:
> > +  tags:
> > +    - $CI_TAGS
> >     artifacts:
> >       paths:
> >         - artifacts/
> >       when: always
> >   include:
> >     - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/ci-fairy.yml'
> >     - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/debian.yml'
> >     - ci/gitlab-ci/yml/kernel-combinations.yml
> 


