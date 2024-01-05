Return-Path: <linux-kernel+bounces-17896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E068254B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A891C22BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA952D7B2;
	Fri,  5 Jan 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hMBOzfsB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCD2D78A;
	Fri,  5 Jan 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ye4MthzdCrdscO8xZ8bE4MdMFIQJf4C4n/xCw/V+vdw=; b=hMBOzfsB2KhNhK662KY1ZfRmXZ
	jT6sW8hQ0c87Esk5Lb/BnKUInouwfXzMrIy6TaqpF7/UfG86O8pnqx5lSrgVhTTnhxUZUKWI53RaL
	9vlhfBK5m+deAl6l3Wz+YysSVgawrXLN0oU+BUT2m2V36fisGGfdgv84cMowAXHTqtqw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLkcK-004SPP-Ok; Fri, 05 Jan 2024 14:52:08 +0100
Date: Fri, 5 Jan 2024 14:52:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Message-ID: <8ef607b9-1fc6-485b-a6fb-a8d468cc1954@lunn.ch>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>

On Fri, Jan 05, 2024 at 04:48:31AM +0200, Sergey Ryazanov wrote:
> Hi Luo,
> 
> thank you for explaining the case in such details. I also have checked the
> related DTSs in the Linaro repository to be more familiar with the I/O mem
> layout. Specifically I checked these two, hope they are relevant to the
> discussion:
> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> 
> Please find my comments below.

Hi Sergey

There is a second thread going on, focused around the quad PHY. See:

https://lore.kernel.org/netdev/60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch/

Since it is very hard to get consistent information out of Luo, he has
annoyed nearly all the PHY maintainers and all the DT maintainers, i'm
going back to baby steps, focusing on just the quad pure PHY, and
trying to get that understood and correctly described in DT.

However, does Linaro have any interest in just taking over this work,
or mentoring Luo?

	  Andrew

