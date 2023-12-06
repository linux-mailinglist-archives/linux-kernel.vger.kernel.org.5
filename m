Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC9807A21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442920AbjLFVI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbjLFVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:08:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5AAD6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:09:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d076ebf79cso1662125ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896943; x=1702501743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0jZIh33WJZDOGC0jgw5Fc4RYCqpyNHwEvNXaQB/Zzg=;
        b=XG1UMychDGvLI1nGeQMU7BYFeIanHRqEH9y4oH8/imC6Cqc2MFi9PryXlhFGgWYOaW
         suBK0gYzw4jzb8IHEieNdqvqZKLH3+X4dNQ5KJdi3wOh40PA1gaOUt4cy6P/6w5c1GQU
         wWyTaUxjwVZIT9ZrxRV/NiYy16u4AF7yi1xVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896943; x=1702501743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0jZIh33WJZDOGC0jgw5Fc4RYCqpyNHwEvNXaQB/Zzg=;
        b=iBv7L9eJZTgwKvSPklDc5hfyvR5KFVwb4H0I/2ta0USk1g4A2K3lMCDmR0owodevdO
         9XY4CL1q1V2bjFOpsh9NmnPwV8VjNoJSDMLvqJ+KcoTLjdywDAopwm+LnPEmoHarz4PW
         qIGfNby9fMpDAtVxNzB62M3B2OilJ3TDLjey8u/J83WiTK0y2sbE5gpDZYn2f+eXD1lT
         iLNxrfM/vW7ZDBmT5rnOrAQUR9iN6ztI+sS61L1zrMWuG7kwIOEqROGRp1i/xQM9bAPt
         b6o5ottNfd6avKumltSk14IclWyKzwMpu/hUcCUMVe+aIkirVLmXD5etvmUJnXgBW1OA
         +CvA==
X-Gm-Message-State: AOJu0YzOc914EiJ8rz3wwWFuRoqDYSyfN7PmLcLpHFIzaakXgBzb4UIn
        tVH6nmq/cM9/IK35GCYMzidwpw==
X-Google-Smtp-Source: AGHT+IFQfQna/1EdVH0X+3X9HH+a9W9KXtDeaY2iTQz/5U8JSAc0AgMNRHkYjwLaZszqnToXGMyAxQ==
X-Received: by 2002:a17:903:22cd:b0:1d0:7165:3faf with SMTP id y13-20020a17090322cd00b001d071653fafmr1374702plg.63.1701896942889;
        Wed, 06 Dec 2023 13:09:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jm21-20020a17090304d500b001d06b93c66dsm244368plb.233.2023.12.06.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:09:02 -0800 (PST)
Date:   Wed, 6 Dec 2023 13:09:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <202312061308.630C56CCA@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <87edfzavof.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edfzavof.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 10:05:36PM +0100, Florian Weimer wrote:
> * Kees Cook:
> 
> > On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
> >> Report available page shifts in arch independent manner, so that
> >> userspace developers won't have to parse /proc/cpuinfo hunting
> >> for arch specific strings:
> >> 
> >> Note!
> >> 
> >> This is strictly for userspace, if some page size is shutdown due
> >> to kernel command line option or CPU bug workaround, than is must not
> >> be reported in aux vector!
> >
> > Given Florian in CC, I assume this is something glibc would like to be
> > using? Please mention this in the commit log.
> 
> Nope, I just wrote a random drive-by comment on the first version.

Ah, okay. Then Alexey, who do you expect to be the consumer of this new
AT value?

-- 
Kees Cook
