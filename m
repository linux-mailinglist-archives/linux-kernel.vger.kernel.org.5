Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8357C7F1022
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjKTKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjKTKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:19:02 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20BEA4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:18:57 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54887484d0bso451609a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475536; x=1701080336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mpjNaJompao/Eu3273sR8jB7ryD7Xh0dcC+At10JAc=;
        b=LVvUI4FV/YysIRaCIfcv6myfOrSvWvyJnkPluEL0OxJluWiQaglDBQ5RJjj6YBZ8Fn
         rDh21DUz7cNrSX4s7YWEDUOCLPC9fr2sn6zS9gi6SJFEAn0PVszPMJKBMdaN/LJR6pZp
         Gibx6QPMHMxmyX9RXXWCCrGz80I5Y3XIbW3PcerXgAok84Q9AaK4OrVMMy/BLTjE7ksu
         ajvK81CbVqw0BY39NcAYmmBnvxn2QDDc94ulKcgXmCKkXjPXqY3GkbdbyKgP6GxOLfED
         sbn2Gd+ijHciB3aGooGpkmrqUZUmfwgVD3gSVaRADaFZxeVx3dK8KV/dQ38SFehz79Wf
         FlOA==
X-Gm-Message-State: AOJu0YzHazGwToMh5saovKvMwQj9tbFN+PLwo4dt5GLRuRcenoMiDvGd
        ssf+PIQCyvuKrbue3g+vWzE=
X-Google-Smtp-Source: AGHT+IFmW7cO7hdhtkh7+AXPePkas883ITLj2r+7GLg2FlUoz7jfsfx2GUpkgIDxBqLV9DLvLvh4xg==
X-Received: by 2002:a17:906:10cf:b0:9cb:b737:e469 with SMTP id v15-20020a17090610cf00b009cbb737e469mr4829185ejv.4.1700475536100;
        Mon, 20 Nov 2023 02:18:56 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709062bc800b009dd8473559dsm3718134ejg.110.2023.11.20.02.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:18:55 -0800 (PST)
Message-ID: <2fc7ca93-3ad7-4127-b779-76c32f8d9124@grimberg.me>
Date:   Mon, 20 Nov 2023 12:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, randyj@purestorage.com,
        hcoutinho@purestorage.com
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
 <20231117132846.GB7867@lst.de>
 <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
 <20231120082346.GA11622@lst.de>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231120082346.GA11622@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 10:23, Christoph Hellwig wrote:
> On Fri, Nov 17, 2023 at 09:38:19AM -0700, Keith Busch wrote:
>> The effects log is per-CSI so different command sets won't create
>> conflicts.
> 
> True.  But that wasn't the point anyway.  It is that different
> controllers might expose very different namespaes with different
> capabilities.  Maybe a controller with HDD namespaces vs flash might
> be a better example.
> 
>> Namespaces that are not shared don't really matter here because this
>> problem is unique to mulitpath.
> 
> Indeed.
> 
>> It doesn't make sense for effects logs to be different per-controller
>> for the same shared namespace. The spec doesn't seem to explicitly
>> prevent that, but hints that all hosts should be seeing the same thing
>> no matter which controller they're connected to:
> 
> Also agreed as already indicated in the past mail.

Having every ns get its own effects log cache is another 4k per nshead.
Even if we restrict it only to iocs its 1k per nshead.

Would it make sense to have nvme_free_cels fence passthru commands
with an rcu instead?
