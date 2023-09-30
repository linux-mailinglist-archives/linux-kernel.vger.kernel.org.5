Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386A07B4223
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjI3QaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:30:01 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1C7C6;
        Sat, 30 Sep 2023 09:29:59 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af603da1d0so2565384b6e.3;
        Sat, 30 Sep 2023 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091398; x=1696696198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmSqdSmc5TEoBJX6RDRaP5oaJBKL1pf1cWoTbq0emmo=;
        b=R4AVx+568bEQAHERi8vCn0ntcaQ1sT9oN6n3w33Kn2jlxZxP4TfBacacScEQa4lXhU
         swGygTSTRS81kOOsO+70Ss7ys1UzwxLbmh/7zeBKMfwiwmPBS7PU7qFCpLKh3JLELrMw
         1wSaEV96BsnMbpXfrIeO0e6lwpv0900PB9WoyGoJvJ2ByAWPMI0TWTAz7eOYCODiCnKn
         9YP1S3x1AbYSBF+EFq6z6FgzW5mb5NbJkeL8TrhrKZNm3jWKvTBHaIPrZ8Du3omhUUUU
         RulhOFYVxdnqLG6iGordXqT2hLH17iNzs9h+OyztTD5ECO4Rqco1rh2HAZVjEKVhqq5a
         Ay/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091398; x=1696696198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmSqdSmc5TEoBJX6RDRaP5oaJBKL1pf1cWoTbq0emmo=;
        b=xG/GmYZpigc/niG0pnEhmQftv+0Eh1BMRfWmPb+IvNPpfnmRAqWC9AqfgcpvxGxkKL
         8kqtHIJSbzaAPcJ7aoEgVoNaWr0OA48v5Jd4rI8oZVTPOFUle29VfFeBUHgE0LwiLT5x
         4eV4ElZPrnxXm8ojuUBAeWbWvpeZr9Qh/L5VQ2HhEUl3zdx5SKVT0/FBXgPZbcknLRmP
         homOyaifHAMyCsEb4mMM7JRNPcRWanSp/OqQ722ca26q3sfEnPRVEBJHaZF4GzWvt47J
         4bH3D6r1cKN0qxTbM+G8w0DnZPGFveDA+xTW0yy4OJSGKFgwFAl6xK9JhyCNH/++8Qvk
         Pqbg==
X-Gm-Message-State: AOJu0Ywv4VyhF8A7r9Z/ARU1Sxhmy3aPx4pUxJf8viUpd6crOCCy96e2
        3hDM5N8cE9Zjjc7xafSVXAcwkKJnBq7hog==
X-Google-Smtp-Source: AGHT+IFJ1l1yE+Ucl76dX4VVFUyJwrjvSJgUJLnT4nsTdm3UiOCVd/p3cQePD4wsWnfwipBbTLemgQ==
X-Received: by 2002:a05:6870:468c:b0:1d6:3b5f:3211 with SMTP id a12-20020a056870468c00b001d63b5f3211mr7848914oap.31.1696091398443;
        Sat, 30 Sep 2023 09:29:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a90f:2dad:30c1:d923])
        by smtp.gmail.com with ESMTPSA id ff11-20020a056a002f4b00b0068790c41ca2sm5376443pfb.27.2023.09.30.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:29:58 -0700 (PDT)
Date:   Sat, 30 Sep 2023 09:29:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matthias Berndt <matthias_berndt@gmx.de>
Cc:     Vicki Pfau <vi@endrift.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        John Butler <radon86dev@gmail.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Jonathan Frederick <doublej472@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add PXN V900 support
Message-ID: <ZRhNA1QvsP/vegd+@google.com>
References: <2305012.ElGaqSPkdT@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2305012.ElGaqSPkdT@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Fri, Sep 29, 2023 at 07:45:52PM +0200, Matthias Berndt wrote:
> Hi everybody,
> 
> I recently sent this patch to the linux-input list where it was ignored, so
> now I'm sending it again to every email address that get_maintainer.pl gives
> me in the hope that it'll somehow get merged.
> This is a trivial patch that enables support for the PXN V900 steering wheel
> in the xpad driver. It's just a matter of adding the relevant USB vendorId/
> productId to the list of supported IDs. I've tried it and

I need your "Signed-off-by: ..." in order to merge this patch. Please
resend following guidelines in Documentation/process/submitting-patches.rst

Thanks.

-- 
Dmitry
