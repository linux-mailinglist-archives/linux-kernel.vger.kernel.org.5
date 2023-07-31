Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6E7689F3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGaCYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGaCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:24:01 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B5E4E
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:24:00 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58451ecf223so43197307b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690770239; x=1691375039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk52475ZbL9s7/hfzBOCB7Jm9cqV9XCvqs/zZ6NPZQI=;
        b=A3y2ViIQXJShjd6wDFcAEALxDEVLj6N3sTEKT8sUWmBs34mm+rMeempLoiJIHa2zG1
         tq3ygHbhY5MtzqqQCTATOvrkevDCft1psD9WA8pO1bif5w+Mb7BdG7R1BXaUypurKP6N
         g03kK0r+XdXPzLPGHeG06LmfIVx2cLQkeC2AjGzFoU4YcNA8Nxqq8aw4eqAsgs65KMCM
         E8+EUgd3D4lVZdIytzC2PTGefQ+Vkr4duSJ1jgxH4sh0qgaB3oykGeOKjIP6oF6TAThh
         6Bhc+gO/TsWAcQ6u+Tz7+gk2BaiCiB/FFi/8iu7mAA0vi9YAMcRL8UqAFtbCCLshinPx
         fwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690770239; x=1691375039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk52475ZbL9s7/hfzBOCB7Jm9cqV9XCvqs/zZ6NPZQI=;
        b=Te4c5SeqYBxfXhKMJfm8I2RQpf73PKmjzfmAaIbAQijiaiEXsG8Xdm0ap5H8U0WlrG
         1F1og+J3549odqyJ7TpTEKETtiWO5dDF4i1OdC+6H8QdsYxr9JJr2jbxJCmBiUn6lbJF
         r1u7JWycYil445hIFAnk5BIUpbK+Y+rzxevb/y/MKRci2ib7QGkzEUbZUc6YfpS0Ar3i
         pioWdgNWd31IzkZuGZkqg1N6GM8ixFB5Itzp2/yrkgD/3Nu+IqrRX3vd5X0njCt+4DL5
         WRzyjutkPB1duL/tuzO98EMVupQD9KEkCdNCTdPgobiQwlTjhC/bwFBJBEL1Otyz1Pw1
         9ztw==
X-Gm-Message-State: ABy/qLbbNaizkgI3tRhkz8GIjpHqQZxmdzRWf7GgK28XZlRYSJiwzBqh
        KjvRAteOg+aksy9jWFWPX1cj67aH8fSqRkj8Qh/R
X-Google-Smtp-Source: APBJJlF/Wa6E65w9i694QuPBH13WOZNSoYTN04HjKpK8cAA2FZgHoTfFjHgOfV3D0dQqbSGb2eRDPI/L7r/b+0q3F3Q=
X-Received: by 2002:a81:74d4:0:b0:577:1909:ee15 with SMTP id
 p203-20020a8174d4000000b005771909ee15mr8587315ywc.6.1690770239668; Sun, 30
 Jul 2023 19:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230726191036.14324-1-dtatulea@nvidia.com>
In-Reply-To: <20230726191036.14324-1-dtatulea@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 31 Jul 2023 10:23:48 +0800
Message-ID: <CACycT3vzcEXfB4OBgP4GF=F+j21gs8WDyepkZQWYwnYFTURbpQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:11=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Gal Pressman <gal@nvidia.com>
>
> Free the cpumask allocated by create_affinity_masks() before returning
> from the function.
>
> Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading m=
echanism")
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
