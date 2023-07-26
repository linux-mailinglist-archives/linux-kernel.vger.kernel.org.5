Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA6763007
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjGZIjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjGZIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:38:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826E455B5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:28:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52256241b76so1937757a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690360098; x=1690964898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNQhgI3bztXsDKLKL9Y51hRanaV6IoqzrzInBKdjpB4=;
        b=EskMqoHcrf+I1oDvZ7vE+vwdKapI2s4EtPHSd2O6GRmPDAQgEnsg4w2DuFGlJBZkYw
         ocIssKw1G5HEEK48lpLYg7iG3fHlvnxlherMdtpBvVhh5v4Ga8lpe+w5OLop13ui6ixn
         AwWFvow+tkZvLjq6RfGsOPqdzy24w//lZGjr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360098; x=1690964898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNQhgI3bztXsDKLKL9Y51hRanaV6IoqzrzInBKdjpB4=;
        b=fB2ntxKJ1D75wewegRC9VOTeaI27vPDh+xcWbfYywq5WG74Pc9OV4oHbSI16emLXnn
         M9AplOxvp5oQCCbMdIqBQIbIF4+o7YQaWnZ2bAj9OLVdceiqhGdOg7xrpEqJTDx55qSR
         O+bySUpm2QlCWLK+Rx8xFgP2HFgm7EhEVjZj948r9DUw/8QnHhfO/h0SN0gzac+JMwq2
         sI36esPcFGEBDMiXgg5OuuQ1b4AjxE0bGaHIaoGVzPwrRNgNyF2dnPD5vxctIZBtWVbo
         jMp9Wj/76aLyWdwhLi7HFVdMZY2HQdBAUW8OWf9gRQgGMrw3wFQGOgrwH16sMq0CF424
         0bQw==
X-Gm-Message-State: ABy/qLbvdL+/tzzn6CdJ7dSTj4kqi+RXMzofWPp7Ds5P3TH7HAUS5JzD
        0j/qedF2c7IdBiESEhM5HKZVlhhoOlcJ3z2LY5dB49aDw3Ho9ZSUH4E=
X-Google-Smtp-Source: APBJJlGd15R95sOTqLbRdv7fFyc+q6u6i0ZUzRxw/mCnaiFn/PjKBrTza/CNFkF+qTar8yZLD+EHTg1UeDSvSqGEe6o=
X-Received: by 2002:a05:6402:129a:b0:522:4d1b:3acf with SMTP id
 w26-20020a056402129a00b005224d1b3acfmr841200edv.37.1690360097943; Wed, 26 Jul
 2023 01:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230723150658.241597-1-jdamato@fastly.com> <20230723150658.241597-3-jdamato@fastly.com>
 <d950f4f6-6581-a99f-3375-c0359d45c9f5@gmail.com>
In-Reply-To: <d950f4f6-6581-a99f-3375-c0359d45c9f5@gmail.com>
From:   Joe Damato <jdamato@fastly.com>
Date:   Wed, 26 Jul 2023 11:28:06 +0300
Message-ID: <CALALjgwVj4ZQ351djbSTqbzVDWPrmJxX7yXweYKXbTtLz0aZ9w@mail.gmail.com>
Subject: Re: [net 2/2] net/mlx5: Fix flowhash key set/get for custom RSS
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     netdev@vger.kernel.org, saeedm@nvidia.com, ecree@solarflare.com,
        andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        leon@kernel.org, pabeni@redhat.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:59:32PM +0300, Tariq Toukan wrote:
>
>
> On 23/07/2023 18:06, Joe Damato wrote:
> >mlx5 flow hash field retrieval and set only worked on the default
> >RSS context, not custom RSS contexts.
> >
> >For example, before this patch attempting to retrieve the flow hash fields
> >for RSS context 1 fails:
> >
>
> Hi,
>
> You are adding new driver functionality, please take it through net-next.

Thanks for reviewing the code I sent; I made the changes you requested and
sent a v2, but through net-next this time.
