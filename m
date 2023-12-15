Return-Path: <linux-kernel+bounces-1356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC466814DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788B9285531
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEBD3FE58;
	Fri, 15 Dec 2023 17:07:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B63FE55;
	Fri, 15 Dec 2023 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id ADB5C20640;
	Fri, 15 Dec 2023 18:07:37 +0100 (CET)
Date: Fri, 15 Dec 2023 18:07:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Jiri Slaby <jirislaby@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-iio@vger.kernel.org, netdev@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Alex Elder <elder@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <ZXyH1Zv3Pxd6S3ag@francesco-nb.int.toradex.com>
References: <20231214170146.641783-1-francesco@dolcini.it>
 <ZXxWX-Fw1InID2ax@hovoldconsulting.com>
 <ZXxa7yzKzG6048vw@francesco-nb.int.toradex.com>
 <ZXx8bCVyxJ9Ddvqm@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXx8bCVyxJ9Ddvqm@hovoldconsulting.com>

Hello Johan, Greg

On Fri, Dec 15, 2023 at 05:18:52PM +0100, Johan Hovold wrote:
> On Fri, Dec 15, 2023 at 02:55:59PM +0100, Francesco Dolcini wrote:
> > To me the change is correct, with that said probably this should have
> > been explicitly mentioned in the commit message or a separate
> > preparation patch.
> 
> It's a separate change and should not be hidden away in a tree-wide
> change that goes through a different maintainer.
> 
> Please drop this change from this patch and resubmit it separately to me
> if you want and I'll review when I have the time.

Fine, I agree.

I see those options (let me know if you see other options I have not
mentioned):

1. I add this change (taking into account also intel ice) as a separate
   patch in this series and you may just ack it and Greg could merge
   together with the serdev one.
2. I prepare an independent patch for the GNSS change and only once this
   is merged I'll send a rebased v2 of this one.
3. I update this patch without this GNSS API change, that mean I will
   have to cast away the signed type from a few GNSS drivers.

1 is my preferred option, 2 is fine, but it seems a little bit of overdoing,
3 I would avoid, we are doing this cleanup to be a little bit more
strongly typed and to prevent the kind of bugs that is the original trigger
for this patch.

What would you Greg and Johan prefer?


> And when doing tree-wide changes, please try to follow the style of the
> driver you are changing (e.g. do not introduce inconsistencies by
> changing to open parenthesis alignment of continuation lines in code
> that do not use it).

ack, sorry about that, looking back at the archive is seems a recent
pain point, also Jiri fell in this trap.

Francesco


