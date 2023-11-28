Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAA7FB0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjK1DuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjK1DuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:50:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E1D45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:50:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26702C433CA;
        Tue, 28 Nov 2023 03:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701143426;
        bh=rUzlbwnwEjMuYJ5IqzIor5c2caIY5fV4IWy4R8Nuxks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a0o6bTTtfgxVYFWoheHsb4monVNkuJFNFdx+rPAXE6EUCydIiMCzu+xGAzoNeLzTL
         m3adAo/l1QwzyaUjTMgFXzwOh34ERD8kmjMxFPt5Ihlfgu4T+YLGjMIW/5RBlJJ6nT
         sZXvtK+jtAc+viWZuxV484q2SKbTv+8Dxzq7hBoahpAemIU3asd4JDJawZHzouagkz
         tDme3LWxBudMQ9U24510F2VZdA7xFReUQuX8JgF8zGBZ4xtOcKYLB+eTAA+r8Wyq0Z
         MJkXiKPrRHNvsWJLsBMWLnVGTJg3JSN7e3VV4WRPLHM3inDoE/+VV7qEEzAUvyuOGj
         aTHs+HqPyh0gg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso7590248e87.1;
        Mon, 27 Nov 2023 19:50:26 -0800 (PST)
X-Gm-Message-State: AOJu0Yz9GiPzXqdAbkOPcJRV8+Vg8ycGjKOkiKicFJVE1mMn++FVtin9
        WMvnNtPgyV1NIDDWRpiWvKqRwGzZ++PUuCk86/Y=
X-Google-Smtp-Source: AGHT+IGDjBDlrqSWJXvdZnc0hDl+kIlfgezKloDDV2IGGYQWZx5FTf4ga8MR7D433aE3JaPLuWUwNldnUauCbhc3Gmw=
X-Received: by 2002:a05:651c:3d1:b0:2c9:a274:a511 with SMTP id
 f17-20020a05651c03d100b002c9a274a511mr3716655ljp.43.1701143424266; Mon, 27
 Nov 2023 19:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Nov 2023 19:50:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4sSVBiicnDY_3MTznNkJjrdL8mpDXyJpXLOt_eBybcgw@mail.gmail.com>
Message-ID: <CAPhsuW4sSVBiicnDY_3MTznNkJjrdL8mpDXyJpXLOt_eBybcgw@mail.gmail.com>
Subject: Re: [PATCH -next v3 0/5] md: remove rcu protection to access rdev
 from conf
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 12:16=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v3:
>  - remove patch 1 from v2, and since all the print_conf() is called
>  while 'reconfig_mutex' is held, it's safe to remove
>  rcu_read_lock/unlock() directly.
>  - remove the definition of flag RemoveSynchronized;

Applied v3 to md-next. Thanks!

Song
