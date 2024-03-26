Return-Path: <linux-kernel+bounces-118539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAFF88BC61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7441C2FE04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423811369A7;
	Tue, 26 Mar 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPX+K2s6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA8134422;
	Tue, 26 Mar 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441712; cv=none; b=apgpVcIwBOAzF844+6yhSBortkIurwKa7OmMXkpRUJEFUI+b8NjQ764gQcel7kJ4OlYG2rP0To5+CXYSZ6o5zx4AHee8UMUpjE7mu/4FKEqpxoquSCDKSu5XiRACCSiyfOaGvfnICnT47GIS1Xs4R+Fe4iXTs1TQ7kwb3m/yTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441712; c=relaxed/simple;
	bh=rAq3xkAVaETYPSPHUg5emdE8mb8m91SeBHFnjLnSNn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SloYujdLCU+fF3FxFixPxdUOMrLqhMGBudM1MO/ZpMoCjGl2GJGdaPabkB66HHKqX+jdtXJZTWxNaGEPQiBIsBMA/v1QyZxmfNNsDHRgPNxq1mEfOkVm0sobCT0qSbIo7wq/iQsI5Fw5CLZMxwc9SK7yHzUf0YgRf3HJnzTAZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPX+K2s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC61C43390;
	Tue, 26 Mar 2024 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711441712;
	bh=rAq3xkAVaETYPSPHUg5emdE8mb8m91SeBHFnjLnSNn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPX+K2s6Vr6NTDLfB3RrMOcdU+ZZLsM3yi6/UuG1rCLWGYX+tW6sSPLzry0FeTlqg
	 P/ZWca+hJGB2i/WX4iK9602OM20iNmLSN2gdhbKNT9wIn2yp/uUJy++OrzzRuhRDqs
	 ggx07RkbJigaK8eTh8Asbbpd29MpB7P34PzZMBU0NzxjJXhXbgvg7/7FZHo/3UTnhK
	 JcKUrZ8WIA5I0UbhzsY9cEY3gg5rT0w1Stga4RJUAySOJ8nhfubewH1k6a6H283WWC
	 pyoqRKPvhhYj2tsqznMU3vZqc9g4oP2xVCKmufFZ4UdB+fM6ttcXopv0p6gbxMNZMw
	 O1nkLix+uYzWA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp2Ag-0000000060q-3Qe3;
	Tue, 26 Mar 2024 09:28:39 +0100
Date: Tue, 26 Mar 2024 09:28:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Message-ID: <ZgKHNuziNtBhGO9V@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-8-quic_kriskura@quicinc.com>
 <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
 <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>
 <ZgF6zvaT2OkrbkHK@hovoldconsulting.com>
 <807015d4-c5ed-4e04-9948-fd1ff894a04e@quicinc.com>
 <ZgHUR-Rk-YzqiTtt@hovoldconsulting.com>
 <7b4a6d7f-76ad-471f-a178-dc598fbc0e22@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4a6d7f-76ad-471f-a178-dc598fbc0e22@quicinc.com>

On Tue, Mar 26, 2024 at 01:41:52PM +0530, Krishna Kurapati PSSNV wrote:
> On 3/26/2024 1:15 AM, Johan Hovold wrote:
> 
> > Just change the logic in dwc3_qcom_find_num_ports() so that it returns 1
> > if "dp_hs_phy_1" is missing, and otherwise you determine the number of
> > ports by iterating from 2 to DWC3_MAX_PORTS - 1.

> I made this change and it works. Removed any return value check for the 
> find_num_ports call as it can return only 1/2/3/4 now.
> 
> ---
>      irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
>          if (irq > 0)
>                  return 1;
> 
>          irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
>          if (irq > 0)
>                  return 1;

As I mentioned above, these two lookups are no longer needed and should
be removed.
 
>          irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_1");
>          if (irq <= 0)
>                  return 1;

Just assume it's a single port controller unless "dp_hs_phy_1" is
present.
 
>          for (port_index = 1; port_index < DWC3_MAX_PORTS - 1; 
> port_index++) {

I think this would be more readable if you use port (num) as iterator
(2..DWC3_MAX_PORTS) as you're returning a number of ports.

>                  sprintf(irq_name, "dp_hs_phy_%d", port_index + 1);

Then this would use just "port";

> 
>                  irq = platform_get_irq_byname_optional(pdev, irq_name);
>                  if (irq <= 0)
>                          return port_index;

And return "port - 1" here.

>          }
> 
>          return DWC3_MAX_PORTS;

Johan

