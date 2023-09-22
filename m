Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B257ABB07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjIVVXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjIVVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:23:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E03EE;
        Fri, 22 Sep 2023 14:22:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EFDC433C7;
        Fri, 22 Sep 2023 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695417779;
        bh=Q+ZNUcuL61Fk9Y9p5nUgrrqgCloEuZiBbOn0VzUydkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kjaBKcca1u8TqhyK/GW7p5Futxh8PbgeZ4QdauZDce25f+hBZpMS3YWbDZ/v/tdg7
         Q8mM55X89WPZXhQqC5f+/e3dh2m9P4EH8UhVhtNZu6yDtyhDC8TuoU3DjDu8pki1d1
         VboXk/nAbFYbIf3qJdjhVKEZo7KunaQwrrZFOcIxln9Dcjvsp94jBMRKMqxKRZgibc
         a5Rdg0VbaGpMnP/NsPVhngRYktpyk+WMyi/ztT19Q/tXlohbbso0CNd1he1YfjPO1p
         uxP6QnGshYUD+MQ/dWohuHaja1CcnYOV6E2/HJTdIAJvoRvhtyM3clIQRfeDynSA2P
         /1//+c0rYZXYQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-503012f4e71so5305627e87.0;
        Fri, 22 Sep 2023 14:22:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywcc3LyTDcPHT0f+Z0gzs57hY3x5kSuRVatFlcxPlsOyqZ6yUAc
        3hhV3Km7ux+EKhKcYfaJ/B1z4idmMa/elDE/7ZQ=
X-Google-Smtp-Source: AGHT+IHwGjysy8Z4sQw6DBTW5YcmbOyypNyTWsh0RBvq21KMfEd7zS1EI3UtRN5b27IozTFaPYWJXNDQJruaEhC74RI=
X-Received: by 2002:a05:6512:239d:b0:500:a93d:fc78 with SMTP id
 c29-20020a056512239d00b00500a93dfc78mr377349lfv.31.1695417777679; Fri, 22 Sep
 2023 14:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911065010.3530461-1-yukuai1@huaweicloud.com>
 <20230911160540.0000060e@linux.intel.com> <b2754d8e-dfe7-ffff-66ac-052f366530e4@huaweicloud.com>
In-Reply-To: <b2754d8e-dfe7-ffff-66ac-052f366530e4@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 22 Sep 2023 14:22:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW59JAy7q2B1DeCbKGVAap4pOrfXuyzs9T9KOnaM-4VSdA@mail.gmail.com>
Message-ID: <CAPhsuW59JAy7q2B1DeCbKGVAap4pOrfXuyzs9T9KOnaM-4VSdA@mail.gmail.com>
Subject: Re: [PATCH -next] md: simplify md_seq_ops
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 6:02=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
[...]
> >> +static void *md_seq_start(struct seq_file *seq, loff_t *pos)
> >> +{
> >> +    struct md_personality *pers;
> >> +
> >> +    seq_puts(seq, "Personalities : ");
> >> +    spin_lock(&pers_lock);
> >> +    list_for_each_entry(pers, &pers_list, list)
> >> +            seq_printf(seq, "[%s] ", pers->name);
> >> +
> >> +    spin_unlock(&pers_lock);
> >> +    seq_puts(seq, "\n");
> >> +    seq->poll_event =3D atomic_read(&md_event_count);
> >> +
> >> +    spin_lock(&all_mddevs_lock);
> >
> > I would prefer to increase "active" instead holding lock when enumerati=
ng over
> > the devices. the main reason is that parsing mdstat is implemented in m=
dadm, so
> > it could kind of blocker action- for example mdmon follows mdstat so it=
 is read
> > frequently. The time of getting other actions done can highly increase =
because
> > every open or sysfs_read/write requires this lock.

Existing code holds pers_lock can seq_printf() in md_seq_show(). Do we see
issues with this?

Hi Kuai,

This patch doesn't apply cleanly to md-next now. Please rebase and send v2.

Thanks,
Song
