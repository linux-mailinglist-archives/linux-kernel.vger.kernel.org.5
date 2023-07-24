Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C391F75EF00
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjGXJVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjGXJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:21:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F491A5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C02F61006
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C06EC433C7;
        Mon, 24 Jul 2023 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690190461;
        bh=hYZSp23/VZnyiPenBn/BSzT12KqKsEamnSBdtafgomc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OP36OM8W0zUYoWak6ujK1nziRzxIwc3NzUMcDxlJb3NcXVc/BeTct4m+aQvAMsQIN
         ejeCmrw6fAV+i/Z/AgnOItsEeDwU4VfYrQKlx0/tTZgNchGLAXZ28QI5B6PdYVQqlt
         FvBfY038tmRqh32hVXBWfABl1ZBMMBZxioXJtCyI7yOqFbc3YtduUO7Noby9r26NH/
         GAyExsvv/UH3PtcUApVZ0gtBRzLldGeOpD5z2RgdOGfNSp6Mizs5osLguKnWeww1s1
         zIza8uCegyQrtFn7XLhoYXXniBWRxqVax1lveb2yY4IzXP1OHcXHNOwQxxmwt/yczO
         m21AK7S3JqWFQ==
Date:   Mon, 24 Jul 2023 10:20:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>, davem@davemloft.net,
        linyunsheng@huawei.com, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230724092055.GB11203@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
 <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org>
 <20230712115633.GB10768@google.com>
 <CAJedcCzRVSW7_R5WN0v3KdUQGdLEA88T3V2YUKmQO+A+uCQU8Q@mail.gmail.com>
 <a116e972-dfcf-6923-1ad3-a40870e02f6a@omp.ru>
 <CAJedcCz1ynutATi9qev1t3-moXti_19ZJSzgC2t-5q4JAYG3dw@mail.gmail.com>
 <CAJedcCydqmVBrNq_RCDF2gRds39XqWORFi32MV+9LGa5p28dPQ@mail.gmail.com>
 <20230717130408.GC1082701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717130408.GC1082701@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023, Lee Jones wrote:

> On Sun, 16 Jul 2023, Zheng Hacker wrote:
> > Zheng Hacker <hackerzheng666@gmail.com> 于2023年7月16日周日 10:11写道：
> > >
> > > Hello,
> > >
> > > This bug is found by static analysis. I'm sorry that my friends apply
> > > for a CVE number before we really fix it. We made a list about the
> > > bugs we have submitted and wouldn't disclose them before the fix. But
> > > we had a inconsistent situation last month. And we applied it by
> > > mistake foe we thought we had fixed it. And so sorry about my late
> > > reply, I'll see the patch right now.
> > >
> > > Best regards,
> > > Zheng Wang
> > >
> > > Sergey Shtylyov <s.shtylyov@omp.ru> 于2023年7月16日周日 04:48写道：
> > > >
> > > > On 7/15/23 7:07 PM, Zheng Hacker wrote:
> > > >
> > > > > Sorry for my late reply. I'll see what I can do later.
> > > >
> > > >    That's good to hear!
> > > >    Because I'm now only able to look at it during weekends...
> > > >
> > > > > Lee Jones <lee@kernel.org> 于2023年7月12日周三 19:56写道：
> > > > >>
> > > > >> On Mon, 10 Jul 2023, Jakub Kicinski wrote:
> > > > >>
> > > > >>> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > > > >>>> For better or worse, it looks like this issue was assigned a CVE.
> > > > >>>
> > > > >>> Ugh, what a joke.
> > > > >>
> > > > >> I think that's putting it politely. :)
> >
> > After reviewing the code, I think it's better to put the code in
> > ravb_remove. For the ravb_remove is bound with the device and
> > ravb_close is bound with the file. We may not call ravb_close if
> > there's no file opened.
> 
> When you do submit this, would you be kind enough to Cc me please?

Could I trouble you for an update on this please?

Have you submitted v4 yet?

-- 
Lee Jones [李琼斯]
