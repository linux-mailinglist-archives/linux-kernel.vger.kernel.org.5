Return-Path: <linux-kernel+bounces-27467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B382F095
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D30428585C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640471BF37;
	Tue, 16 Jan 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4jEQCA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E51BDEC;
	Tue, 16 Jan 2024 14:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A51C43390;
	Tue, 16 Jan 2024 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705415711;
	bh=YxRAEs1+500SQYSJEteA7haAvPYo8UdPYN9Xe9/mIio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4jEQCA1oX2gdAuwVRAq1lU9gfTshP5xoyXgnUw5fC28RHQN1BTC/y12Wp2JP8d2Q
	 ZifSys3WVBpWG10QhMIvdm8TRX/BQ0MIIOVa0vPaMbzKxrkQyAxIwkhptUb+9RQa+f
	 2M7l3yDoJJsO9wq/DESwzXCATOm/bGMCzQRPnnghsL+qwphJBAtxUsSX4L8w4CMAZ9
	 wZ8WgqQkQf65IsRckBsyg91ZU4ILHZUBhRLHY1FDOzfJ0oXwNtXeB8vhNgvgtlIiQp
	 Ccgf4p10qpBOo8A0I4sbezUfWKcyK3F41Xj7hRikxXHJbQsxywodU7C0SZWNeW/S5k
	 MsPjEWUqjaYfg==
Date: Tue, 16 Jan 2024 08:35:09 -0600
From: Rob Herring <robh@kernel.org>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: vichy.kuo@gmail.com, Pintu Kumar <quic_pintu@quicinc.com>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, frowand.list@gmail.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] of: reserved_mem: fix error log for reserved mem init
 failure
Message-ID: <20240116143509.GA3845101-robh@kernel.org>
References: <20231206151600.26833-1-quic_pintu@quicinc.com>
 <20231208203128.GA2646347-robh@kernel.org>
 <CAOuPNLg90T69USVQ8Ti6c8fXb_XrnaR035in_CbJHmNMUYLqOg@mail.gmail.com>
 <CAOuPNLj4_pQiAHoER2VJpW_2NEaq8+zF8p1br+tf0Toe1t1UDg@mail.gmail.com>
 <CAOuPNLh+V1-Uu_rnnbdu7p6DGjHOJf0yJnaxnchwpzh_YyP=_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLh+V1-Uu_rnnbdu7p6DGjHOJf0yJnaxnchwpzh_YyP=_Q@mail.gmail.com>

On Sat, Jan 06, 2024 at 11:31:12PM +0530, Pintu Agarwal wrote:
> Hi,
> 
> On Thu, 14 Dec 2023 at 22:47, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > On Mon, 11 Dec 2023 at 20:13, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, 9 Dec 2023 at 02:01, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 06, 2023 at 08:46:00PM +0530, Pintu Kumar wrote:
> > > > > During fdt_init_reserved_mem() when __reserved_mem_init_node()
> > > > > fail we are using pr_info to print error.
> > > > >
> > > > > So, if we change the loglevel to 4 (or below), this error
> > > > > message will be missed.
> > > > >
> > > > > Thus, change the pr_info to pr_err for fail case.
> > > > >
> > > > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > > > > ---
> > > > >  drivers/of/of_reserved_mem.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > > > > index 7ec94cfcbddb..473665e76b6f 100644
> > > > > --- a/drivers/of/of_reserved_mem.c
> > > > > +++ b/drivers/of/of_reserved_mem.c
> > > > > @@ -334,7 +334,7 @@ void __init fdt_init_reserved_mem(void)
> > > > >               if (err == 0) {
> > > > >                       err = __reserved_mem_init_node(rmem);
> > > > >                       if (err != 0 && err != -ENOENT) {
> > > > > -                             pr_info("node %s compatible matching fail\n",
> > > > > +                             pr_err("node %s compatible matching fail\n",
> > > >
> > > > Isn't the message just wrong. If compatible match fails, we return
> > > > ENOENT. The failure here would be from the init function.
> > > >
> > > Okay.
> > > You mean to say, if __reserved_mem_init_node fails with default err
> > > (ENOENT) then it may not hit this condition.
> > > Instead it will hit the 'else' case which is wrong ?
> > > Also, the "initfn" inside "__reserved_mem_init_node" may fail in which
> > > case also it may return default err.
> > >
> > > Maybe, the initial author's intention was to free the memory only if
> > > the failure type is not the default ENOENT type.
> > >
> > > This seems to be a different issue.
> > > Can we address this separately in a different patch ?
> > >
> > > And how do we fix this ?
> > > One option is to add another "if" condition with just ENOENT error check ?
> > > if (err == -ENOENT) {
> > >     pr_err("node %s compatible matching fail\n", rmem->name);
> > >     return;
> > > }
> > > Then, correct the existing log with a different message:
> > > pr_err("node %s matching reserved mem not found.\n", rmem->name);
> > > Or, add one more "if else" condition ?
> > > Or, fix the calling function itself : __reserved_mem_init_node ?
> > >
> >
> > Any further comments on this ?
> 
> Any further comments or suggestions on the above ?
> Shall we just fix the log message, or correct the if/else case as well ?

It looked to me like the original author's intent was this is not an 
error. Either convince me otherwise or wait for me to study this 
further. This code gets a lot of drive-by patches and what is "correct" 
isn't always clear.

Rob

