Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5480AC28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574614AbjLHSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLHSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:38:02 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4FFC6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:38:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so1830025b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702060688; x=1702665488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtN8RJrSywNd9cqTGDXuX00rE8787z779s5kNZbKPTg=;
        b=eNU1EAx2H0cVhDiB2lfoDQan7fEfMz5udTwfcMi9THoBeXBj746nTvWMWjNVPI/oae
         7u+kXee+wGaH5DFIw6qBonTMD7k84kKyGR+guCa69j7SvDmbG4aK+5dbRq51nuD/XUdv
         QUFMyM/mvvGSEpHl888CNEbL3R2m1SDSlUWCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060688; x=1702665488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtN8RJrSywNd9cqTGDXuX00rE8787z779s5kNZbKPTg=;
        b=ItwkBFVbje6kfhhhQmMgAoXc/CtXRhoF6KxoAufTq1LoiOrZmXVwm3geYEMjybVIpF
         prLYSCxslzzFCkmzFGOdizw2nMpoQwBf9vgjmhr0cE8KedvLge4X1xusL9vRSBnxnIc7
         H2mlFZL+fWTyDeTGdp0dIffXXjXRfyvG2EaCw1H+FurUvDwejoKlDGLPSWGkLcNJD1Cf
         yUsK66RaMMY0ef545+t4jDhQsR5wtfKeuQlkH7AxM9L6Pd3FiT9W78sJ+Xo/6Ko2ashl
         Z3riQfKHnRCuTNzQN9L7kvoietaUdt/TN3mbJcYUgjDEBvUQkE4h11dPSC18zhW3nhDP
         iLrw==
X-Gm-Message-State: AOJu0Ywo9RL+UYbYOAfwOUvtvl1kFYzF/0Ez2aOkbHfvJcXX2au8QvNS
        /43VtDtIbEg5MosVx+TCZ7aSjA==
X-Google-Smtp-Source: AGHT+IHJzNo7Hbj+hV0vS5OXcDWV8L1dA0GJLnVKpqyuVHtDw1XXI/AWkfGTwQ2ZZjG7MnXsry4Z7g==
X-Received: by 2002:a05:6a20:918b:b0:18f:97c:823b with SMTP id v11-20020a056a20918b00b0018f097c823bmr529965pzd.69.1702060688480;
        Fri, 08 Dec 2023 10:38:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o73-20020a62cd4c000000b006c875abecbcsm1966803pfg.121.2023.12.08.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:38:07 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:38:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <202312081037.895E558@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
 <202312081027.BA44B7B3@keescook>
 <87lea4czki.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lea4czki.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 07:35:25PM +0100, Florian Weimer wrote:
> * Kees Cook:
> 
> > I significantly prefer APIs not being arch-specific, so I'd prefer we
> > always include AT_PAGE_SHIFT_MASK. For an architecture that doesn't
> > define its own ARCH_AT_PAGE_SHIFT_MASK, it's not _inaccurate_ to report
> > 1 << PAGE_SHIFT, but it might be incomplete.
> 
> The downside is that as an application programmer, I have to go and
> chase for the information the legacy way if I encounter
> getauxval(AT_PAGE_SHIFT_MASK) == getpagesize() for a longer time
> because the interface does not signal the absence of any extended
> page sizes.

Are there architectures besides x86 where AT_PAGE_SHIFT_MASK isn't a
single bit? If so, let's get them added now along with x86.

-- 
Kees Cook
