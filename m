Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087178F19A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjHaRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjHaRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:01:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85CD1;
        Thu, 31 Aug 2023 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1693501265; x=1694106065; i=fan.ni@gmx.us;
 bh=12xJbrsFviKVQ6obHknRx+VPF50PuuJTDbIVzk6hhXQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Vxf9y1yoqlziysECGrBWWhHShju+yas7a0zOHisUbhz1Gikj3nwN/n8W1w5ulS6JrzsNt2q
 pP5U44vrqo5yAVTEV5bQxpk7JvmQArOqFP1o7q+J5XU8e80mmg4yFglvUWdNUaF2B6F9+I94z
 qo+qn7bU8Ur85pmj0xVJO9JsSZQjYyOPUfQD9LE+2HyKxkOcaiX+YuUpBxTCzpPXcwTnoodCu
 HHT7SNjtw+kc0rkMVD3ix9a/Gh53RW3wXT0woIYJbM9hGk6qmwsz5wSYRY+49squyVU6GM17X
 M0UGv9lYCieKnMVW2+MYbN7lLh9G6wsVwAe9j3ENQqxSx80Q53Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1qfbrS2TF8-003uwQ; Thu, 31
 Aug 2023 19:01:05 +0200
Date:   Thu, 31 Aug 2023 10:00:50 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/18] cxl/region: Add Dynamic Capacity decoder
 and region modes
Message-ID: <ZPDHQnLctLmRIxaS@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-4-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v2-4-f740c47e7916@intel.com>
X-Provags-ID: V03:K1:Wo30mn8KL5AYnbXla4xHQE/ks0lbOf6H+vps7K5NMiSPQmOo86H
 yHdYKjwSZeorZVLVgvOSjtIE1Pj6VK/1HDhIr/Z3/bhieC6Q1eKZfW6FepxDkfmsK1gyYbL
 nWDYPHmXCHyQNi6V9Ru4Ob//shufS6rmFaqxRs2GU3Z/rpblLcE9l94haCnwvDtt7a+PP4b
 Bz2NWD9MMuAy3jogTmljg==
UI-OutboundReport: notjunk:1;M01:P0:YRBXR8R57cE=;TOED1LF3wD16BU3J2YyjnBOtFxv
 kGl/08Otca/LP4aJcIY6BmKTdjYzubRe+Lkan0QwtdHRZvOZt+1umW24N7UYPLGUSxipUjRHi
 seyLo6jXq0lW+nfVuqsaGlTJihL43gDmR4GZ7mDPPaV0K5MsF0XweWIiFwUqptscRZzm9z9GD
 xEmJb1gpcHr6JU2zl1KmDS30hhwNTWGJTmuzHtRCU9+psjkjoXrYS2RFMHWzcUqVYmOTXVzzv
 bUA4XT0m9UQqpqNKkyF7zyUIEnZZ2poflsQAtPT1ptJSyZOcBZhsOYvZDyxlJqmEZ3SBZ4vHx
 hIk8621FE/lfB1qSfzP4iG/QAt6mqGYI2lWnXOegwiZC9ay607Z5HuHEv3R3Zid6WChEKkmcE
 6AyIx97VwtJAE9vsECsy05NGPNx4M7rWSzj4HjrxkWQ8WXAB+Lyv2zImODcb58K2+13PpV2rt
 8QXa4xINx5uOF6a4pKFHbCBPxlsL+Ql1W7Xo5wBwuxQ4RTcGDGDTgi4F1rsn/73bHRjdScLF9
 p48FDfpsVS8ca9c04/+j/qIybYWYuXy6xr3jD2l068VH7X26KDg3sVPXNzcp7ZTjeIJWfK1yn
 BcYKxdqPVHBrTjFC4ykbTyU+txYAt9k9SIVpELVLQwtMiQkLVkpIfV28Tx/d7BEDPcEChdqHE
 hyZPTGQbIu/PD2T/Cw5yapWzIq/KmeqiQV32aiFkmOJMyWYL/1EDei/GzYGUZb02vC8fxo4UK
 6z8Fv7v4izEZ/NQU/vh5opFkB1iNFvRtaC63FDJMCoRc+Ly/XX+bCU05c0XsJGBtaImy+3vpi
 u4GwnTfb0uGUXmFGwf7oNiDLDgrzjKNXsmladindObLkhAw2TMj2jUEzusXvsFYuWNBkkxffs
 on676OcLGnuFND0wkoJrwdy9Wjdz2VutLyRsc5Bk2DpVWfjX1/otmbWt13MVytk3BkNP9zy7Q
 fnaO2nxw7z/B8b18+odW8pi7APc=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:20:55PM -0700, Ira Weiny wrote:
> Both regions and decoders will need a new mode to reflect the new type
> of partition they are targeting on a device.  Regions reflect a dynamic
> capacity type which may point to different Dynamic Capacity (DC)
> Regions.  Decoder mode reflects a specific DC Region.
>
> Define the new modes to use in subsequent patches and the helper
> functions associated with them.
>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Changes for v2:
> [iweiny: split out from: Add dynamic capacity cxl region support.]
> ---
>  drivers/cxl/core/region.c |  4 ++++
>  drivers/cxl/cxl.h         | 23 +++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 75041903b72c..69af1354bc5b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1772,6 +1772,8 @@ static bool cxl_modes_compatible(enum cxl_region_m=
ode rmode,
>  		return true;
>  	if (rmode =3D=3D CXL_REGION_PMEM && dmode =3D=3D CXL_DECODER_PMEM)
>  		return true;
> +	if (rmode =3D=3D CXL_REGION_DC && cxl_decoder_mode_is_dc(dmode))
> +		return true;
>
>  	return false;
>  }
> @@ -2912,6 +2914,8 @@ cxl_decoder_to_region_mode(enum cxl_decoder_mode m=
ode)
>  		return CXL_REGION_PMEM;
>  	case CXL_DECODER_DEAD:
>  		return CXL_REGION_DEAD;
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> +		return CXL_REGION_DC;
>  	case CXL_DECODER_MIXED:
>  	default:
>  		return CXL_REGION_MIXED;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ed282dcd5cf5..d41f3f14fbe3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -356,6 +356,14 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> +	CXL_DECODER_DC0,
> +	CXL_DECODER_DC1,
> +	CXL_DECODER_DC2,
> +	CXL_DECODER_DC3,
> +	CXL_DECODER_DC4,
> +	CXL_DECODER_DC5,
> +	CXL_DECODER_DC6,
> +	CXL_DECODER_DC7,
>  	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
> @@ -366,6 +374,14 @@ static inline const char *cxl_decoder_mode_name(enu=
m cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] =3D "none",
>  		[CXL_DECODER_RAM] =3D "ram",
>  		[CXL_DECODER_PMEM] =3D "pmem",
> +		[CXL_DECODER_DC0] =3D "dc0",
> +		[CXL_DECODER_DC1] =3D "dc1",
> +		[CXL_DECODER_DC2] =3D "dc2",
> +		[CXL_DECODER_DC3] =3D "dc3",
> +		[CXL_DECODER_DC4] =3D "dc4",
> +		[CXL_DECODER_DC5] =3D "dc5",
> +		[CXL_DECODER_DC6] =3D "dc6",
> +		[CXL_DECODER_DC7] =3D "dc7",
>  		[CXL_DECODER_MIXED] =3D "mixed",
>  	};
>
> @@ -374,10 +390,16 @@ static inline const char *cxl_decoder_mode_name(en=
um cxl_decoder_mode mode)
>  	return "mixed";
>  }
>
> +static inline bool cxl_decoder_mode_is_dc(enum cxl_decoder_mode mode)
> +{
> +	return (mode >=3D CXL_DECODER_DC0 && mode <=3D CXL_DECODER_DC7);
> +}
> +
>  enum cxl_region_mode {
>  	CXL_REGION_NONE,
>  	CXL_REGION_RAM,
>  	CXL_REGION_PMEM,
> +	CXL_REGION_DC,
>  	CXL_REGION_MIXED,
>  	CXL_REGION_DEAD,
>  };
> @@ -388,6 +410,7 @@ static inline const char *cxl_region_mode_name(enum =
cxl_region_mode mode)
>  		[CXL_REGION_NONE] =3D "none",
>  		[CXL_REGION_RAM] =3D "ram",
>  		[CXL_REGION_PMEM] =3D "pmem",
> +		[CXL_REGION_DC] =3D "dc",
>  		[CXL_REGION_MIXED] =3D "mixed",
>  	};
>
>
> --
> 2.41.0
>
