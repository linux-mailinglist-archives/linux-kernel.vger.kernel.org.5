Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B90772D52
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHGRyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjHGRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:54:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1F10F7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:54:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso2624546a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691430852; x=1692035652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkNfaSnlIfsLOIfFSVY477nb7kMuVaWgXxFM3c4pXxM=;
        b=vqFTAPcGMpDvPBY8O4uOkBUn3GupwA77jhN4VIB8wKx15+My5VYv1jPuEHLfOpDE7V
         3xx5Q+aabNTLml8nxIaLHXASMvLaLjlUk5pULl9JYUfHNzugmnSS8afDAqXL4FryjKCh
         TiGYPW6B8AuF50G01F1dzhT0m+Pu04xZJhWBLcZAQ+YV4HOwrEVgjQQbHzavur3OQ6iT
         P9m1pockso+4P6uoCFc/9TzWCuoUgX7i7BShGW26oek4AQM+1wPaWtHe6lZgR1rphSnC
         ExL+7er7rg6N9icye1jW9Xne9GOOIKsz0s/QKK1ch7Ne7VlZB4WA2Coq5IowjOgXSUAD
         kI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430852; x=1692035652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkNfaSnlIfsLOIfFSVY477nb7kMuVaWgXxFM3c4pXxM=;
        b=IWgD07+tC37vmmWJL3WL02x1TmIZoUGcjESJnIPRlP4yQ3vz3CFD36tnhdIxewbicL
         xVEvZn/lqZa7HYnE0SkyErtBKV/71wv9Qh5+zIEaDrQ1hHMRyLdDP+h7rjNEhkzNhU6H
         Oslyc/Tr7PA1ZDvrUxzPbC0H824lT6ysgW3dup0qyA0sV9fLJZ8s1vVwEsF9oRVxdD63
         39lSZF3B905JF175riflBx9Z4o7G4OkDm9qu6Sm0eU6thqBhdpskMEedRVntPx+KnA3F
         rbIKP9RuJDU909deMLmHL0Bhy4qBB+O00HCvx3uszKFMHg5f3eH4LYyVstVf5xm1t7O2
         RoSg==
X-Gm-Message-State: AOJu0YxVdwOARHICvvZQtl/WLCA2d//1+7I73oxnNzNspj4Pdj0VEp3f
        U44R4k/hOVwubU8JzR+MXM47gfRvM0LLbZohjzUejg==
X-Google-Smtp-Source: AGHT+IHNBUJ74OtlOrasacNp4TjktRMZpVjklCDjXsoDWbKkKlp5+YMekbdKPMQI/BEz1dnjg4FqacRt3qCXKxELJyg=
X-Received: by 2002:a17:90a:e645:b0:262:df1d:8e16 with SMTP id
 ep5-20020a17090ae64500b00262df1d8e16mr7475579pjb.33.1691430851697; Mon, 07
 Aug 2023 10:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230807075118.128122-1-xiafukun@huawei.com>
In-Reply-To: <20230807075118.128122-1-xiafukun@huawei.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Mon, 7 Aug 2023 10:54:00 -0700
Message-ID: <CAOReqxjEBZ+ZQQiTaCjGZMqSMCqxpgzS2o16oGCxM81EfvA_9g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Fix incorrect use of sizeof in sof_ipc3_do_rx_work()
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     peter.ujfalusi@linux.intel.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        cujomalainey@chromium.org, noah.klayman@intel.com,
        daniel.baluta@nxp.com, rander.wang@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 12:52=E2=80=AFAM Xia Fukun <xiafukun@huawei.com> wro=
te:
>
> Here hdr is a pointer, and we should measure the size of
> struct sof_ipc_cmd_hdr.
>
> Fixes: 12c41c779fad ("ASoC: SOF: Refactor rx function for fuzzing")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>

Thanks for catching this

Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
