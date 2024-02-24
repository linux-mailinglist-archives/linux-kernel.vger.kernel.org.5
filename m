Return-Path: <linux-kernel+bounces-79501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F2A862353
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3991F1F23E40
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA770168CD;
	Sat, 24 Feb 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHxUgCVd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941D10A2B;
	Sat, 24 Feb 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708760131; cv=none; b=eG8doVW4Ri1nql9nSlN6CDhPfIBipEQbNdHwH3fTakh+aWWZpWb/KovieouWum3orWNKq7LpStOO6TF4yfvOM/F40etfJ5orfBAnQUiS0I/Zt763tgUpYltHXFvt5k1xrVy/2negTH9Ntx2CotjJS7nFQr2vhu0t/8IsicQkXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708760131; c=relaxed/simple;
	bh=q2/5MqZPz2HDD14dYiI1H5yCstXYofd3cv/H8+6ocWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2KojHwquEGOcSOUvog++2D5eYYOdibOTWvWeXe9WqE5Cbxnyqm+26WBWcj2N96BSJSoqCu3YPFkCtMNfkkG5b8aRRWhbVSE4w6g/GyfY0+OMkcMX/la1yA+IBItqDNjHR8PnYvWNGWMfMkOWssO4SR4ux2NWrfIyFUTZfF8oAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHxUgCVd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708760129; x=1740296129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2/5MqZPz2HDD14dYiI1H5yCstXYofd3cv/H8+6ocWU=;
  b=HHxUgCVdIuIVKmdZap7AHR0BAoekH5voFIdpgd8p/1bQlM0KDS6q0RCu
   6xDaAg4Q/E5G7S1uimLHJzs7zEYlxbNltbDZur7e9C6vM1AHErK9R+HvW
   5AS796TtPEdcMFUANQyrWalpu7eH6rgj8GD86WUxV3noBn6vxnnqtliR9
   nBKQW0dJNlK3QTBZpM5KElwShQ1WZG5V+avsr3jnH2Ur8ZvdrevNsrMyk
   Yho1WQlAEysSx2YdIl+/xF8XJ6YpXL+dDiVaI9X/oNqo0SKr1tgWX8eBP
   8cTa2AF5l400U1cxRTtjPvpwzqkO2JbCTSCy4rPPRdJwfUbILv/0aRsvs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6045032"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="6045032"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 23:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="6143052"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 23 Feb 2024 23:35:25 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdmZ4-0008L2-2j;
	Sat, 24 Feb 2024 07:35:20 +0000
Date: Sat, 24 Feb 2024 15:34:51 +0800
From: kernel test robot <lkp@intel.com>
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	marius.cristea@microchip.com
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding support for PAC193X
Message-ID: <202402241545.xf7CnlPz-lkp@intel.com>
References: <20240222164206.65700-2-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222164206.65700-2-marius.cristea@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b1a1eaf6183697b77f7243780a25f35c7c0c8bdf]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC193X/20240223-004332
base:   b1a1eaf6183697b77f7243780a25f35c7c0c8bdf
patch link:    https://lore.kernel.org/r/20240222164206.65700-2-marius.cristea%40microchip.com
patch subject: [PATCH v5 1/2] dt-bindings: iio: adc: adding support for PAC193X
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240224/202402241545.xf7CnlPz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402241545.xf7CnlPz-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml:51:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

vim +51 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml

     8	
     9	maintainers:
    10	  - Marius Cristea <marius.cristea@microchip.com>
    11	
    12	description: |
    13	  This device is part of the Microchip family of Power Monitors with
    14	  Accumulator.
    15	  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found here:
    16	    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
    17	
    18	properties:
    19	  compatible:
    20	    enum:
    21	      - microchip,pac1931
    22	      - microchip,pac1932
    23	      - microchip,pac1933
    24	      - microchip,pac1934
    25	
    26	  reg:
    27	    maxItems: 1
    28	
    29	  "#address-cells":
    30	    const: 1
    31	
    32	  "#size-cells":
    33	    const: 0
    34	
    35	  interrupts:
    36	    maxItems: 1
    37	
    38	  slow-io-gpios:
    39	    description:
    40	      A GPIO used to trigger a change is sampling rate (lowering the chip power
    41	      consumption). If configured in SLOW mode, if this pin is forced high,
    42	      sampling rate is forced to eight samples/second. When it is forced low,
    43	      the sampling rate is 1024 samples/second unless a different sample rate
    44	      has been programmed.
    45	
    46	patternProperties:
    47	  "^channel@[1-4]+$":
    48	    type: object
    49	    $ref: adc.yaml
    50	    description:
  > 51	        Represents the external channels which are connected to the ADC.
    52	
    53	    properties:
    54	      reg:
    55	        items:
    56	          minimum: 1
    57	          maximum: 4
    58	
    59	      shunt-resistor-micro-ohms:
    60	        description:
    61	          Value in micro Ohms of the shunt resistor connected between
    62	          the SENSE+ and SENSE- inputs, across which the current is measured.
    63	          Value is needed to compute the scaling of the measured current.
    64	
    65	    required:
    66	      - reg
    67	      - shunt-resistor-micro-ohms
    68	
    69	    unevaluatedProperties: false
    70	
    71	required:
    72	  - compatible
    73	  - reg
    74	  - "#address-cells"
    75	  - "#size-cells"
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

