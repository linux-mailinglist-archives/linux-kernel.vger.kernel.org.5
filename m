Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507697F9C57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjK0JFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjK0JFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:05:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EDC10F0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:05:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a00a9c6f283so527832566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701075900; x=1701680700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI0TOtQb9c447DbOQLQ1/RG9mFnY5yOZxPwrai0TcrQ=;
        b=sNcgMdc+JCKXIKSMPFi6NUk/N15L2yczsAzRIJsgqu0S5aOv1m8G6qIpAFiX8tMjVC
         4Wy8HhQDJ879kYAUKR+zPMNels22XSb3JzaUFxs2ZfCKcxEbvsivLWPY1ihbVXI2nw0q
         fa+YldVKngt8Ze08ZAkTmoU5Q3wIfQren2nY0/aTfEZNoBntbpRr/BmKKK+11CBiq+Ou
         3GwmEOMRz42Fc10SLihyW3D4wbdBrpKWt1b9PPDPgWbw3hgCT/LQpmi9vwoBwsXLHQZ9
         S3VA4peeeURBmD9DdudAEHZM/aJQ9ZnLTRQziZhiu5+R5h6j3xB67KKcl503gFv10SAX
         Mkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075900; x=1701680700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI0TOtQb9c447DbOQLQ1/RG9mFnY5yOZxPwrai0TcrQ=;
        b=eZYdRvycHH8o1ptMnr7WjIsM1ORZbFcFkFKALFROAEQv8NvKvt3JDW2scXPqVv6unk
         d0VNBj0qTOSJcKkGCN3wQDpTlI0TnaoP+DciYG7WCAaF49esN/tX54FQGtDzfhvK9byI
         SuenudtZYVC1vSE6XGoUqFl/LUCQgBcc+WXCrPRO4s6ltvRUCzUvLy/YXBBenEb3qXXk
         qju1cGp++tAiKOchxesaYskwnkAvqBMI3vKTqsQ7egOjYl/3hMR73x4eN0OP7b8NBgjR
         jNGEpx8Dsx8Rk2CtYjPIdIFSTqoe9cqqZoVfUoy9o+L6tritnzOZUHh+QPnEV1MTN89R
         lkdg==
X-Gm-Message-State: AOJu0YxwTNsTWkbVBOODBBFn6XG54XXk1XcygNqmThE4O5VggtkFiCm3
        8jO9vOLNbK30Sr7lH43svWLY3g==
X-Google-Smtp-Source: AGHT+IGMN9QxP+tvYaW8enwn4HK0hNu5SbKLzvuHC5a2fj6GapL9xeT02R6kafwcgd/VY4ZU0ooFsg==
X-Received: by 2002:a17:906:9d05:b0:9ff:6257:1b4c with SMTP id fn5-20020a1709069d0500b009ff62571b4cmr6439371ejc.37.1701075900268;
        Mon, 27 Nov 2023 01:05:00 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906050a00b009fc54390966sm5508751eja.145.2023.11.27.01.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:04:59 -0800 (PST)
Date:   Mon, 27 Nov 2023 10:04:58 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/14] net: intel: start The Great Code Dedup
 + Page Pool for iavf
Message-ID: <ZWRbusSZ4v0SuWmF@nanopsycho>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Nov 24, 2023 at 04:47:18PM CET, aleksander.lobakin@intel.com wrote:
>Here's a two-shot: introduce Intel Ethernet common library (libie) and
>switch iavf to Page Pool. Details are in the commit messages; here's
>a summary:
>
>Not a secret there's a ton of code duplication between two and more Intel
>ethernet modules. Before introducing new changes, which would need to be
>copied over again, start decoupling the already existing duplicate
>functionality into a new module, which will be shared between several
>Intel Ethernet drivers. The first name that came to my mind was
>"libie" -- "Intel Ethernet common library". Also this sounds like
>"lovelie" (-> one word, no "lib I E" pls) and can be expanded as
>"lib Internet Explorer" :P
>The series is only the beginning. From now on, adding every new feature
>or doing any good driver refactoring will remove much more lines than add
>for quite some time. There's a basic roadmap with some deduplications
>planned already, not speaking of that touching every line now asks:
>"can I share this?". The final destination is very ambitious: have only
>one unified driver for at least i40e, ice, iavf, and idpf with a struct
>ops for each generation. That's never gonna happen, right? But you still
>can at least try.
>PP conversion for iavf lands within the same series as these two are tied
>closely. libie will support Page Pool model only, so that a driver can't
>use much of the lib until it's converted. iavf is only the example, the
>rest will eventually be converted soon on a per-driver basis. That is
>when it gets really interesting. Stay tech.

The world would not be the same without intel driver duplicates :/

Out of curiosity, what changed? I always thought this is
done for sake of easier out of tree driver development and old device
support dropping.
