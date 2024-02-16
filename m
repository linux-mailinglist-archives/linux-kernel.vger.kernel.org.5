Return-Path: <linux-kernel+bounces-68183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17A8576EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F121C21787
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81817745;
	Fri, 16 Feb 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irYxqIcO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260017C76;
	Fri, 16 Feb 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069346; cv=none; b=X/hJ3QWc5oh6aHjesOpTWWjhbgrvXDUQpVC3luD73B6qcknRB6Y0Th4S/TFQXmBNIIHD2sbL76NEtshHaZsX2k2RElZJZ6UyCa/c+Q8CQdG4bzvAo3fpVwJS53ZR+TFSApedzSh1vHHvVtHHVbgOivGNZGpucXYeIjQ7weA5eTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069346; c=relaxed/simple;
	bh=WVzVo94cjOJUH5Yy0UJb0/1D1AALm0kE4w3zgqTVFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E04JOSwQw9WvyXgS8oDaG4DHU8QBpqKxoJ3GIc5CgMV0PNQJGS2V45qh6K2ndLN3IljfKjWrhaqeO1Shiu3NCyqlaClh9mog1gcbxLxypV5210aMPsH1XxA6CZuCsiiYtKhb0ozekBjV55bwgl4UrlpzVp9jzbEUws5mPxy6AAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irYxqIcO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708069344; x=1739605344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WVzVo94cjOJUH5Yy0UJb0/1D1AALm0kE4w3zgqTVFfg=;
  b=irYxqIcOsES2/dPUhia1XyS4uGw8GDksnBkJQXCuCbkn5FnwRJnts6qZ
   lEnPRtOrjeAozpRLC8gdvsHXiXehXalKg0ge+Fxjluf72MTEi7/C0BWsz
   xPBEIE5HC3h5k8zOcLE544q/Uw2bmmxaMhkNmVQhokwtqLJAh2k3doTZK
   sJfM85KumrQhthEKw2F/9cLw5MUqYBEG4DAabxW7CK6/PkEJ9mSOPZtDU
   A97Rqp7Szdl57la7UeTeVlIE4FE4jtDxH+4mtlD7R3/Ls+P3SHfWwVz4+
   F5wT62aRyWmwK2uWaQuU6qVgb33aP1NJJ1pEiTLOaZFDVbJcVApI+u5Tb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5159207"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="5159207"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 23:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912319542"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912319542"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Feb 2024 23:42:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rasrQ-00014i-1u;
	Fri, 16 Feb 2024 07:42:16 +0000
Date: Fri, 16 Feb 2024 15:41:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, broonie@kernel.org,
	robh@kernel.org, andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org, semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 01/12] spi: dt-bindings: introduce FIFO depth
 properties
Message-ID: <202402161543.5JdIODY4-lkp@intel.com>
References: <20240212140331.915498-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212140331.915498-2-tudor.ambarus@linaro.org>

Hi Tudor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next linus/master v6.8-rc4 next-20240216]
[cannot apply to krzk/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tudor-Ambarus/spi-dt-bindings-introduce-FIFO-depth-properties/20240212-221427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240212140331.915498-2-tudor.ambarus%40linaro.org
patch subject: [PATCH v2 01/12] spi: dt-bindings: introduce FIFO depth properties
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240216/202402161543.5JdIODY4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402161543.5JdIODY4-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/spi/spi-controller.yaml:152:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
   Documentation/devicetree/bindings/spi/spi-controller.yaml:156:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

vim +152 Documentation/devicetree/bindings/spi/spi-controller.yaml

     8	
     9	maintainers:
    10	  - Mark Brown <broonie@kernel.org>
    11	
    12	description: |
    13	  SPI busses can be described with a node for the SPI controller device
    14	  and a set of child nodes for each SPI slave on the bus. The system SPI
    15	  controller may be described for use in SPI master mode or in SPI slave mode,
    16	  but not for both at the same time.
    17	
    18	properties:
    19	  $nodename:
    20	    pattern: "^spi(@.*|-([0-9]|[1-9][0-9]+))?$"
    21	
    22	  "#address-cells":
    23	    enum: [0, 1]
    24	
    25	  "#size-cells":
    26	    const: 0
    27	
    28	  cs-gpios:
    29	    description: |
    30	      GPIOs used as chip selects.
    31	      If that property is used, the number of chip selects will be
    32	      increased automatically with max(cs-gpios, hardware chip selects).
    33	
    34	      So if, for example, the controller has 4 CS lines, and the
    35	      cs-gpios looks like this
    36	        cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
    37	
    38	      Then it should be configured so that num_chipselect = 4, with
    39	      the following mapping
    40	        cs0 : &gpio1 0 0
    41	        cs1 : native
    42	        cs2 : &gpio1 1 0
    43	        cs3 : &gpio1 2 0
    44	
    45	      The second flag of a gpio descriptor can be GPIO_ACTIVE_HIGH (0)
    46	      or GPIO_ACTIVE_LOW(1). Legacy device trees often use 0.
    47	
    48	      There is a special rule set for combining the second flag of an
    49	      cs-gpio with the optional spi-cs-high flag for SPI slaves.
    50	
    51	      Each table entry defines how the CS pin is to be physically
    52	      driven (not considering potential gpio inversions by pinmux):
    53	
    54	      device node     | cs-gpio       | CS pin state active | Note
    55	      ================+===============+=====================+=====
    56	      spi-cs-high     | -             | H                   |
    57	      -               | -             | L                   |
    58	      spi-cs-high     | ACTIVE_HIGH   | H                   |
    59	      -               | ACTIVE_HIGH   | L                   | 1
    60	      spi-cs-high     | ACTIVE_LOW    | H                   | 2
    61	      -               | ACTIVE_LOW    | L                   |
    62	
    63	      Notes:
    64	      1) Should print a warning about polarity inversion.
    65	         Here it would be wise to avoid and define the gpio as
    66	         ACTIVE_LOW.
    67	      2) Should print a warning about polarity inversion
    68	         because ACTIVE_LOW is overridden by spi-cs-high.
    69	         Should be generally avoided and be replaced by
    70	         spi-cs-high + ACTIVE_HIGH.
    71	
    72	  fifo-depth:
    73	    $ref: /schemas/types.yaml#/definitions/uint32
    74	    description:
    75	      Size of the RX and TX data FIFOs in bytes.
    76	
    77	  rx-fifo-depth:
    78	    $ref: /schemas/types.yaml#/definitions/uint32
    79	    description:
    80	      Size of the RX data FIFO in bytes.
    81	
    82	  tx-fifo-depth:
    83	    $ref: /schemas/types.yaml#/definitions/uint32
    84	    description:
    85	      Size of the TX data FIFO in bytes.
    86	
    87	  num-cs:
    88	    $ref: /schemas/types.yaml#/definitions/uint32
    89	    description:
    90	      Total number of chip selects.
    91	
    92	  spi-slave:
    93	    $ref: /schemas/types.yaml#/definitions/flag
    94	    description:
    95	      The SPI controller acts as a slave, instead of a master.
    96	
    97	  slave:
    98	    type: object
    99	
   100	    properties:
   101	      compatible:
   102	        description:
   103	          Compatible of the SPI device.
   104	
   105	    required:
   106	      - compatible
   107	
   108	patternProperties:
   109	  "^.*@[0-9a-f]+$":
   110	    type: object
   111	    $ref: spi-peripheral-props.yaml
   112	    additionalProperties: true
   113	
   114	    properties:
   115	      spi-3wire:
   116	        $ref: /schemas/types.yaml#/definitions/flag
   117	        description:
   118	          The device requires 3-wire mode.
   119	
   120	      spi-cpha:
   121	        $ref: /schemas/types.yaml#/definitions/flag
   122	        description:
   123	          The device requires shifted clock phase (CPHA) mode.
   124	
   125	      spi-cpol:
   126	        $ref: /schemas/types.yaml#/definitions/flag
   127	        description:
   128	          The device requires inverse clock polarity (CPOL) mode.
   129	
   130	    required:
   131	      - compatible
   132	      - reg
   133	
   134	dependencies:
   135	  rx-fifo-depth: [ tx-fifo-depth ]
   136	  tx-fifo-depth: [ rx-fifo-depth ]
   137	
   138	allOf:
   139	  - if:
   140	      not:
   141	        required:
   142	          - spi-slave
   143	    then:
   144	      properties:
   145	        "#address-cells":
   146	          const: 1
   147	    else:
   148	      properties:
   149	        "#address-cells":
   150	          const: 0
   151	  - not:
 > 152	        required:
   153	          - fifo-depth
   154	          - rx-fifo-depth
   155	  - not:
   156	        required:
   157	          - fifo-depth
   158	          - tx-fifo-depth
   159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

