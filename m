Return-Path: <linux-kernel+bounces-69163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F3858543
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8930B1F21792
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1A135A48;
	Fri, 16 Feb 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTNUD52m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67741C65;
	Fri, 16 Feb 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108306; cv=none; b=bllmPxcUeAqatn5E3eIE/mY66WbCrncmwFbTGt/4awAiibPynb5iWKACfwzjloqK82yGE+Tto//6mLsNqpGDlWs1Ozlf9bghnOGYgaTZIyzxzAhVbtiszw67sJZnQQ+hyYKl4nwE/bKL3Q87scdsxsYdTAgc0fWwWASBh0eYFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108306; c=relaxed/simple;
	bh=s9cIRkFaKtrccc7vtLJUttfg3iWmA2GqRjx0bO9OYd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU/PikZsBP6SN/8k1zfecuPBrOZh6HDaR1Mp6VaIlk+UPZkKWREdDV9Gd7Ll4XjV7ijTUxx8WW9lcYubG3YQtbCsu9LfQEupwiT71r+48/dkB5uZfa4HqVb1KeMkrAvPKAbZtsnp70l8FiyYISwSPDcdNgr/zd0SKaxuoE7XPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTNUD52m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2258DC433C7;
	Fri, 16 Feb 2024 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708108305;
	bh=s9cIRkFaKtrccc7vtLJUttfg3iWmA2GqRjx0bO9OYd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTNUD52mWWrTFRVL3RFKZTQ4HXBrw8mY1wPxDEkLg0PSOKnV39juO/H8ICq31kwH1
	 IKxlawS6VlNOP3EW5QmnyXC00lx0TOGC9L+oPwAtz5dEERDVKGzPv+DUX0GwJhugfn
	 HYMD/ZHG093YVDxSZ32Nj0tYMiZ9FXqU4TEvO4fW0pkvtLnb6Ryot5KRpWJlRGX0IF
	 RWipJUTEm+YTfUsNsbTkeG2MOXfNF7kCb4Mnfw4JPpPavXsmQBJlgC4DYgD6+pCCJ2
	 3SSIdurWIBj6174ERkqXYqAIOW7ThXrBXUOEZhB59qqV6HGwRgNW+040qtsUIQ97BW
	 74KhpymgE4BJg==
Date: Fri, 16 Feb 2024 12:31:43 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>, Mark Brown <broonie@kernel.org>, 
	konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write
 function
Message-ID: <6lmxlfopjzxbvn5oe6uha2ppdjderuymgq3h3gz2suyb5i2vs6@mpadw4b37s5t>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
 <CACRpkdY7fbFyNNd6GAikxC3+wk0ca8Yn_8__zkp+Q-deJeJ_LQ@mail.gmail.com>
 <3a17f36a-04bf-04f2-7a22-82b76977b325@quicinc.com>
 <CACRpkdbnj3W3k=snTx3iadHWU+RNv9GY4B3O4K0hu8TY+DrK=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbnj3W3k=snTx3iadHWU+RNv9GY4B3O4K0hu8TY+DrK=Q@mail.gmail.com>

On Tue, Jan 09, 2024 at 02:34:10PM +0100, Linus Walleij wrote:
> On Tue, Jan 9, 2024 at 2:24 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> > On 1/9/2024 6:44 PM, Linus Walleij wrote:
> > > On Mon, Jan 8, 2024 at 4:28 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> > >
> > >> It was realized by Srinivas K. that there is a need of
> > >> read-modify-write scm exported function so that it can
> > >> be used by multiple clients.
> > >>
> > >> Let's introduce qcom_scm_io_rmw() which masks out the bits
> > >> and write the passed value to that bit-offset.
> > > (...)
> > >> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
> > >> +{
> > >> +       unsigned int old, new;
> > >> +       int ret;
> > >> +
> > >> +       if (!__scm)
> > >> +               return -EINVAL;
> > >> +
> > >> +       spin_lock(&__scm->lock);
> > >> +       ret = qcom_scm_io_readl(addr, &old);
> > >> +       if (ret)
> > >> +               goto unlock;
> > >> +
> > >> +       new = (old & ~mask) | (val & mask);
> > >> +
> > >> +       ret = qcom_scm_io_writel(addr, new);
> > >> +unlock:
> > >> +       spin_unlock(&__scm->lock);
> > >> +       return ret;
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
> > >
> > > This looks a lot like you are starting to re-invent regmaps
> > > regmap_update_bits().
> > >
> > > If you are starting to realize you need more and more of
> > > regmap, why not use regmap and its functions?
> >
> > I think, this discussion has happened already ..
> >
> > https://lore.kernel.org/lkml/CACRpkdb95V5GC81w8fiuLfx_V1DtWYpO33FOfMnArpJeC9SDQA@mail.gmail.com/
> 
> That discussion ended with:
> 
> [Bjorn]
> > We'd still need qcom_scm_io_readl() and qcom_scm_io_writel() exported to
> > implement the new custom regmap implementation - and the struct
> > regmap_config needed in just pinctrl-msm alone would be larger than the
> > one function it replaces.
> 
> When you add more and more accessors the premise starts to
> change, and it becomes more and more of a reimplementation.
> 
> It may be time to actually fix this.
> 

Thought I had replied to this already, did we discuss this previously as
well?

My concern with expressing this as a regmap is that from the provider's
point of view, the regmap would span the entire 32-bit address space.
I'm guessing that there's something on the other side limiting what
subregions are actually accessible for each platform/firmware
configuration, but I'm not convinced that regmap a good abstraction...

Regards,
Bjorn

> Yours,
> Linus Walleij

