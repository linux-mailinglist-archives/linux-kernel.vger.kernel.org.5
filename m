Return-Path: <linux-kernel+bounces-132745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB9789998D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB9CB21D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3C1607AF;
	Fri,  5 Apr 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpExBfVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E8142E73;
	Fri,  5 Apr 2024 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309642; cv=none; b=riTeSbNHGuCIba3znf2JKL8iNXgELmlDKJ2faklOXGjEFtIW++X5BCwcWZIm1f7CFIRmP/VM7DelQ/tQAs/K3+a3HZvyORrBua5gGw2JA8/I688SATxtMUsc9Zyz7mMEaBVGBefqO2LgFAQ7HYzErthpbhwEpT5GN/sYkQJx8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309642; c=relaxed/simple;
	bh=NiNnjLTs7bJ/pA/1fT9tG+FdpzDELxqauiH0/oieIZc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Vt5fGx60fglzdPqXiAfqL2w+TNDSCUaJwpHpGPzwj1Lo97WkrRp0XQQV1WfZ5gJn3i4s+WFQplQfElajZTFie2pj1LUrjUzhqh6/hSDE7ks4XQd33ZobA6+wcpusvd5hKnGmCoOCWk4ej+xCyl8e94JcEwHhHpxDGGmJjarxHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpExBfVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E043C433C7;
	Fri,  5 Apr 2024 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712309641;
	bh=NiNnjLTs7bJ/pA/1fT9tG+FdpzDELxqauiH0/oieIZc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EpExBfVIoVWyJiDMnIrAUVUAroAPVwax2wJwSWi6O2UUg6EDBUQDYB5m2yGpAPv3C
	 FaDnBN9oFJjSztOLcKSpEwKPA5nX1dPExe5eYVpPv+krSk9k+DGDXSd5MuAnEwmBlN
	 e5+bn1N4v0drvsj3q86qImhIVe2C1Lm6NmYpGH/fsWp5dZ/dBWRvvy/NxtXRY+GCCf
	 lwP6bIotm0t+WUbwoyXNJXQz5HN/9SdmvQmxPqlhIVaWBkB4GLDo8rqHoIWefbUK3L
	 z/ektvzmKv6hw3uZ857vNfcCajwMbEbcKc1SOscXtNJOLfMc7q6J33NtisFLxSSamh
	 fpEK3k1TCqfYw==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,  Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Bjorn Andersson <andersson@kernel.org>,  Konrad
 Dybcio <konrad.dybcio@linaro.org>,  Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Saravana Kannan <saravanak@google.com>,  Geert
 Uytterhoeven <geert+renesas@glider.be>,  Arnd Bergmann <arnd@arndb.de>,
  Neil Armstrong <neil.armstrong@linaro.org>,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Alex Elder <elder@linaro.org>,  Srini
 Kandagatla <srinivas.kandagatla@linaro.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Abel Vesa <abel.vesa@linaro.org>,
  Manivannan Sadhasivam <mani@kernel.org>,  Lukas Wunner <lukas@wunner.de>,
  Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
  linux-bluetooth@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
  linux-pm@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 05/16] dt-bindings: net: wireless: describe the
 ath12k PCI module
References: <20240325131624.26023-1-brgl@bgdev.pl>
	<20240325131624.26023-6-brgl@bgdev.pl> <87msqm8l6q.fsf@kernel.org>
	<CAMRc=MeCjNn7QdDrcQMuj32JFYoemQ6A8WOYcwKJo1YhDTfY+Q@mail.gmail.com>
Date: Fri, 05 Apr 2024 12:33:52 +0300
In-Reply-To: <CAMRc=MeCjNn7QdDrcQMuj32JFYoemQ6A8WOYcwKJo1YhDTfY+Q@mail.gmail.com>
	(Bartosz Golaszewski's message of "Wed, 3 Apr 2024 16:56:01 +0200")
Message-ID: <87cyr440hr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> On Mon, Mar 25, 2024 at 3:01=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wro=
te:
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> >
>> > +
>> > +maintainers:
>> > +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> IMHO it would be better to have just driver maintainers listed here.
>>
>
> Why? What's wrong with having the author of the bindings in the Cc list?

If you want follow the ath12k development and review patches then you
can join the ath12k list. I'm not fond of having too many maintainers,
it's not really helping anything and just extra work to periodically
cleanup the silent maintainers.

I would ask the opposite question: why add you as the maintainer?
There's not even a single ath12k patch from you, nor I haven't seen you
doing any patch review or otherwise helping others related to ath12k.
Don't get me wrong, I value the work you do with this important powerseq
feature and hopefully we get it into the tree soon. But I don't see
adding you as a maintainer at this point.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

