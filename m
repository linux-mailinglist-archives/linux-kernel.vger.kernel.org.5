Return-Path: <linux-kernel+bounces-93408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA91F872F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14B91C243CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358CF5C8E0;
	Wed,  6 Mar 2024 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODMG4cU0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C695C604;
	Wed,  6 Mar 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709278; cv=none; b=PcWihtHWGAifJbgNhj0UUakvYfyN3YaB5Ov/JS6tPAJWw4Mlt8Dz4BnhaVN+6DbdvOVC4IaL566dWUW7uwSeR5MIvctVGdHME494+/0NB0LdFxeES3rLFg/lPWgAfI8IHN89tD23GE++coELl6AMnV0pL2FfkCBG4UCsv0KlGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709278; c=relaxed/simple;
	bh=Q4jNS53sz6z+xgVv/481OuFX1jfdnAmQc8opmwqbePw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpDTs6hVR/xnKnBUYPnNerRXEK4UysFSpEkE34PQq08RQKnJEb3cYYWaTkBzVlhoe9liI+6UNoAwkBk+mvnmXxZEyOaOS6qmn1FPVlhE6Upc1FzWeIgyI4GhaqpTX8qITDzX5tc8hZyvvJPxkzgZa+IJ9E3djcJxXgcLYaxyCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODMG4cU0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709709277; x=1741245277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4jNS53sz6z+xgVv/481OuFX1jfdnAmQc8opmwqbePw=;
  b=ODMG4cU0lRQrleCoQw0ha0qTW3R8SPVUawB+P/fmDE39Om2uTONFIVTG
   5aiqY1XBIEHXfNG1gECHvVnCWMmxkplwcJ+CFEtgcgZtYmL0zAlML0lOZ
   Te4Kld7vzzJ95963siWDtyB99xtwQpb19lLRLoB1UYFmk7qYVtyy5fsFW
   0I5yJAkCvwrR6sY72acmMBUICii16a8TAsw5fzgyrinQxqVkjA0RD1Vtd
   DYx93oUWF+yA8ZNbYf6VPMVzAxesBFQw8XBHO8v8eLs22z/ne6Jk4O/+x
   XcCJVqPmtvGDymYzNnzUQNl/9fe+Pf8TW/7CkoPkXygL4lzQ+lchjR3WN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4164856"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4164856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 23:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14319175"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 05 Mar 2024 23:14:31 -0800
Date: Wed, 6 Mar 2024 15:10:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	yilun xu <yilun.xu@intel.com>, Rob Herring <robh+dt@kernel.org>,
	mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>,
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga <linux-fpga@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema
Message-ID: <ZegW2QpgO0Kk1Iip@yilunxu-OptiPlex-7050>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
 <20240221195058.1281973-3-charles.perry@savoirfairelinux.com>
 <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org>
 <1012793477.1508198.1709486517581.JavaMail.zimbra@savoirfairelinux.com>
 <cb51aadd-c350-42e2-9684-ac4f7dbf864c@linaro.org>
 <d377f0ea-2df2-4d4e-b1bc-8a4ca55eec15@linaro.org>
 <23887452.1534761.1709605624728.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23887452.1534761.1709605624728.JavaMail.zimbra@savoirfairelinux.com>

On Mon, Mar 04, 2024 at 09:27:04PM -0500, Charles Perry wrote:
> 
> 
> On Mar 4, 2024, at 12:31 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:
> 
> > On 04/03/2024 08:30, Krzysztof Kozlowski wrote:
> >> On 03/03/2024 18:21, Charles Perry wrote:
> >>> On Feb 27, 2024, at 3:10 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org
> >>> wrote:
> >>>
> >>>> On 21/02/2024 20:50, Charles Perry wrote:
> >>>>> Document the SelectMAP interface of Xilinx 7 series FPGA.
> >>>>>
> >>>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> >>>>> ---
> >>>>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
> >>>>>  1 file changed, 86 insertions(+)
> >>>>>  create mode 100644
> >>>>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> >>>>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> >>>>> new file mode 100644
> >>>>> index 0000000000000..08a5e92781657
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> >>>>> @@ -0,0 +1,86 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: Xilinx SelectMAP FPGA interface
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
> >>>>> +  parallel port named the SelectMAP interface in the documentation. Only
> >>>>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
> >>>>> +  the clock, with the MSB of each byte presented to the D0 pin.
> >>>>> +
> >>>>> +  Datasheets:
> >>>>> +
> >>>>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> >>>>> +
> >>>>> +allOf:
> >>>>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    enum:
> >>>>> +      - xlnx,fpga-xc7s-selectmap
> >>>>> +      - xlnx,fpga-xc7a-selectmap
> >>>>> +      - xlnx,fpga-xc7k-selectmap
> >>>>> +      - xlnx,fpga-xc7v-selectmap
> >>>>> +
> >>>>> +  reg:
> >>>>> +    description:
> >>>>> +      At least 1 byte of memory mapped IO
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  prog_b-gpios:
> >>>>
> >>>> I commented on this and still see underscore. Nothing in commit msg
> >>>> explains why this should have underscore. Changelog is also vague -
> >>>> describes that you brought back underscores, instead of explaining why
> >>>> you did it.
> >>>>
> >>>> So the same comments as usual:
> >>>>
> >>>> No underscores in names.
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>
> >>> Hello Krzysztof,
> >>>
> >>> Yes, I've gone full circle on that issue. Here's what I tried so far:
> >> 
> >> And what part of the commit description allows me to understand this?
> >> 
> 
> I have a changelog in the cover letter:
> https://lore.kernel.org/all/20240221195058.1281973-1-charles.perry@savoirfairelinux.com/
> 
> >>>
> >>>  1) Reuse the same gpio names: Duplicates errors of the past, Krzysztof
> >>>     doesn't like it.
> >>>  2) Different gpio names for new driver only: Makes the driver code
> >>>     overly complicated, Yilun doesn't like it.
> >> 
> >> That's a new driver, right? So what is complicated here? You have new
> >> code and you take prog-b or prog_b?
> >> 
> >>>  3) Change gpio names for both drivers, deprecate the old names: Makes
> >>>     the DT binding and the driver code overly complicated, Rob doesn't
> >>>     like it.
> >> 
> >> I don't think I proposed changing existing bindings.
> >> 
> >>>
> >>> I think that while the driver code shouldn't be the driving force for
> >>> the DT spec, it can be a good indication that the spec is unpractical to
> >>> implement.
> >> 
> >> What is impractical in implementing this? You just pass either A or B to
> >> function requesting GPIO. Just choose proper name.
> >>
> 
> It's not complicated but it requires more code than if "prog_b" had been
> used. 
>  
> >>>
> >>> In this case, there are two interfaces on a chip that uses the same GPIO
> >>> protocol, it would only make sense that they use the same names, this
> >>> discards solution #2.
> >> 
> >> I don't understand this. You have devm_gpiod_get() in your new code. Why
> >> is it difficult to use different name?
> 
> Yilun asked to avoid changing the names between the two drivers.
> First comment in this mail:
> https://lore.kernel.org/all/Zb9GkY6cMtR+4xOX@yilunxu-OptiPlex-7050/
> 
> Yilun, let me know if this is something you'd accept as this is a concern
> for the device tree maintainers.

I agree that deprecated names should not be used for new DT bindings, while
keeping backward compatibility to exsiting ones, unless there is other
DT side concern.

I'm also good that the driver adapts to the DT binding change.

What I'm concerned is the driver API:

  int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
		      xilinx_write_func write,
  -		      xilinx_write_one_dummy_byte_func write_one_dummy_byte)
  +		      xilinx_write_one_dummy_byte_func write_one_dummy_byte,
  +		      const char *prog_con_id, const char *init_con_id)

You don't have to make every bus driver input the gpio names.  The core
falls back to use old gpio names only for existing devices
(.compatible = "xlnx,fpga-slave-serial").  Then the issue could be
solved?

Thanks,
Yilun

> 
> > 
> > And I forgot to emphasize: none of these is mentioned in commit msg, so
> > for v5 you will get exactly the same complains. And for every other
> > patch which repeats the same and does not clarify caveats or exceptions.
> > 
> > Best regards,
> > Krzysztof
> 
> Should I keep my changelog in the individual commits? I thought the norm
> was to put this the cover letter.
> 
> Regards,
> Charles
> 

