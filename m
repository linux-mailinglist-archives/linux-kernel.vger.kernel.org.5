Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C178F29E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347031AbjHaSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbjHaSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:30:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED3E7A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:30:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c06f6f98c0so9198775ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693506614; x=1694111414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FB1kVMWEU7nPrAJJXjUVrfR6NLc1vMmftYUNizeZ0Cc=;
        b=fMOJ32E4VIbYy5JzVF6rihdyKHh/QFE0hu6aKeDbCUHEXv5hnUP70iF+9/AFoDlSWt
         g2fRzeHTX3Eko5JeQxqDEOqXH9WFQiEIgM7gpgUizKBQYSt8mi+12PSRInVokrAzli9k
         r3lGu3VNCWchmm78WWRBQ9Z1sIaRH4A5T6f9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693506614; x=1694111414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB1kVMWEU7nPrAJJXjUVrfR6NLc1vMmftYUNizeZ0Cc=;
        b=cvgU+gIUpLBIeCbozpP6n8ubFljbabF6fpALaGwJHNFw/J+5tMvWQyItwP1YzYaES7
         puiZXg2diBNmUpiEbl2m36WS7a7t7/OBagKS9a59lQE7+yqoYfiqVmiH4DlUhW9jQj5S
         LnBy3E9/cDbYFt0pJlUbcTCrW2qIH0NA6EIwEtyvWVIIWn2CdNrBEwLhsoYuOE1G+I0Y
         pQ/yzmbcs5tABxbCEx2WTbkq5Tszv48Bebbj9ZeEjZhJkzkSo4CAwWmeGijd/G+sJybZ
         AC2l1OAafTgiVvkIbTrZP99qjBejdjTgftmaykCxc2sdns/NPAdEoFpY85sUjDbd9YH5
         i2Jw==
X-Gm-Message-State: AOJu0YwGj+t8sBvHaokPuVKiXmgtEIODDbltwlLpnOuvFYjVEbWszAvQ
        f21tFsOxixO2XfzsfWiDPSMItw==
X-Google-Smtp-Source: AGHT+IEjQ6KvhqRgqekfwUfVHPDa4H9zY0UwUrk4seishin21Jizv61gXheblqWlJAuPqaS3NuEs8A==
X-Received: by 2002:a17:902:a5c9:b0:1bc:667b:63c6 with SMTP id t9-20020a170902a5c900b001bc667b63c6mr426242plq.41.1693506613996;
        Thu, 31 Aug 2023 11:30:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001bafd5cf769sm1548229plg.2.2023.08.31.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 11:30:13 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:30:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308311123.EF07499@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook>
 <c44d1f9f-90e0-3e83-8394-854feb449539@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44d1f9f-90e0-3e83-8394-854feb449539@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:32:18AM +0200, Jiri Slaby wrote:
> On 30. 08. 23, 23:28, Kees Cook wrote:
> >                  len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> > 
> > This is the anti-pattern (take the length of the _source_) we need to
> > remove.
> 
> But len is the length of kbs, i.e. the destination. Or what am I missing?

strlcpy() returns the length of the _source_ string (i.e. it could be
greater than the input argument len). But there is no current flaw here
(since all sources are very short). We're just trying to remove strlcpy()
since it leads to unexpected results.

-Kees

-- 
Kees Cook
