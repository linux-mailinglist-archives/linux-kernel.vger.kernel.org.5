Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688C78F1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346930AbjHaR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbjHaR0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:26:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5559D1B2;
        Thu, 31 Aug 2023 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1693502752; x=1694107552; i=fan.ni@gmx.us;
 bh=QkNThFNl/IRsfsmzhYGbjpsuKXfa7sROQrJsuIPp6Fk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G8BLnDniCevNBthds3xwEAkfC3HvKYHAuMK5hKt11nSmZuAdWOxv+0B0Fhk2Yxp+VfwMza4
 J7GfQMDVLMWf+jQJbSZsz5hwKHSIBgoRgplhUH0KRfI/UPRt1ouIUh9gBaPKkxx5ePnHizSQF
 XTTXjrPZdgUwPtIRB11K0xoK0V8q2RhDPL7Dygpzoy/QeicqMAnMLhg7JQ0ukLsG2dl3FI9bk
 QnUbGoqAExUAfBfPPNlrmazHwpGTTHTLcrwelCxbNwEw1naxivLcOAJIYzrCzyWmhBJYkJAwB
 1sg0MZxqMf1SC67Qze8Kk1fhBMlJgE08wSOTmMzCTwPmOAquUqMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1q5RkC2JcR-00cQYl; Thu, 31
 Aug 2023 19:25:52 +0200
Date:   Thu, 31 Aug 2023 10:25:40 -0700
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
Subject: Re: [PATCH RFC v2 05/18] cxl/port: Add Dynamic Capacity mode support
 to endpoint decoders
Message-ID: <ZPDNFEi1RRGoTWhr@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-5-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v2-5-f740c47e7916@intel.com>
X-Provags-ID: V03:K1:RV9VBC88o9a7oe/0Gorhbc6mBMd4dbP0AzLP+3WmJC2WF3f4qWo
 XGSRCAgrD92VfjcL3Io/bjl3VipVm24adn/ifUDmdRvKC0T6pKDM+XLVr30VYMYAWeLs/oX
 OvbGcM2Ah8OWAHQ/6/6zZ7FkfJ7pklAHneZ2gIcpZ2i+JrsPrmzvhaKG/2SHf9cCjGc+nXf
 CcUmtQ0/+NvgGq1Amip3Q==
UI-OutboundReport: notjunk:1;M01:P0:bn6trh9Em5A=;nPjKzDeny4W4Pu5WCtxkCvjmE0g
 LiYcHPfgxV5W3j0VbENfJvuf0jof7TKHwFhDZHLoQT6YxJ/DtJtn0EIgGtl2sOyfBVMHoPs63
 axBojDjap9VBm0/R4pMQfaWLSaIsDLk2O+Hm4JmCCHEHlzuE05zFHc9v+xmK4y6SvgGdW6692
 nvCXpg8/QAqdi3EwPZQSh5OLj/Z+kkQbRS8Y6UsaZbH5pKKBABatLGDDsSneA3ftz3L6rLnN5
 VCzuq3yMBIBo0fy8GjivZVS0yQtUOgB2XaUbfQZh4YYLMrhYZMhyo8aUlbRm7EVE0nWPxXsv9
 huxQ+XRZxoHojR4rCNdOXYNV8Ge/kQHMoEHnxtt4rRLc7J0hW3kcPMwP57yQzWrPzKoFPEhhs
 KuNzXWMxz0rEDkAz0iE0NI2mtGGnl3101k31rUmdxE9g/D9qKrGKnDDOn1lfceA8SzMBO8G1b
 xWSfjqshXlGF9qlR8uQtrplhKcqYnh2DrADzCXSwIxOJE+Nro4/WiL1vni+AJz2azWNjeSPgC
 OTU0MfrKMqjym6COxYtTmQWTyuUtOX9qlQFa7lGzfJyb7y3p0AgNOcPTVQWN73vl33woJo2y6
 izT5kwrYfpHYkp83erBNDZBJCFzLXTb3Zn+ov9Omv6tW1/p7wBIvS2eFSY3CvFk2nO8KDoCcx
 jRp5qq6SLwC/30B+U9XNjQdbohIdkedhx5FnMt4j60AsbhVmp9jysXPxJnj5Aubg8ZTKJx7Qw
 ew2/6EM2hnHVmnqm6DSzaj4+HSAGFA3Hx6NQuIst5DRmj7XwPOqdBdaG/XdJIEfikrwwooNGO
 QAu8SpCmqaAwWrfI6ikz6p8nzpkOatv3Gnih83P4j2OemHXbA/rdDJpD/amUb0UvXku/018XJ
 pIqF8f5h4SbDBlWVbMdO6nm8H4/PadG4VSOofsX87wYkNrGBuneW83XGUxzzC4Wnz1IkES/P5
 e9xKnmWjUnVvtu/1GFWsjjm1M4I=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:20:56PM -0700, Ira Weiny wrote:
> Endpoint decoders used to map Dynamic Capacity must be configured to
> point to the correct Dynamic Capacity (DC) Region.  The decoder mode
> currently represents the partition the decoder points to such as ram or
> pmem.
>
> Expand the mode to include DC Regions.
>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>

I have the same question about how dc_mode_to_region_index is
implemented and used as Jonathan.

Nice to see the code spit out, it is easier to review now.

Fan

> ---
> Changes for v2:
> [iweiny: split from region creation patch]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 19 ++++++++++---------
>  drivers/cxl/core/hdm.c                  | 24 ++++++++++++++++++++++++
>  drivers/cxl/core/port.c                 | 16 ++++++++++++++++
>  3 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI=
/testing/sysfs-bus-cxl
> index 6350dd82b9a9..2268ffcdb604 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -257,22 +257,23 @@ Description:
>
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
>  Date:		May, 2022
> -KernelVersion:	v6.0
> +KernelVersion:	v6.0, v6.6 (dcY)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device local
>  		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> +		memory) range, or Dynamic Capacity (DC) range. The 'mode'
> +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> +		'none'. The 'mixed' indication is for error cases when a
> +		decoder straddles the volatile/persistent partition boundary,
> +		and 'none' indicates the decoder is not actively decoding, or
> +		no DPA allocation policy has been set.
>
>  		'mode' can be written, when the decoder is in the 'disabled'
> -		state, with either 'ram' or 'pmem' to set the boundaries for the
> -		next allocation.
> +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> +		the next allocation.
>
>
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index a254f79dd4e8..3f4af1f5fac8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -267,6 +267,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoin=
t_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	int index =3D 0;
> +
> +	for (int i =3D CXL_DECODER_DC0; i <=3D CXL_DECODER_DC7; i++) {
> +		if (mode =3D=3D i)
> +			return index;
> +		index++;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -429,6 +442,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cx=
led,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> @@ -456,6 +470,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *c=
xled,
>  		goto out;
>  	}
>
> +	for (int i =3D CXL_DECODER_DC0; i <=3D CXL_DECODER_DC7; i++) {
> +		int index =3D dc_mode_to_region_index(i);
> +
> +		if (mode =3D=3D i && !resource_size(&cxlds->dc_res[index])) {
> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			rc =3D -ENXIO;
> +			goto out;
> +		}
> +	}
> +
>  	cxled->mode =3D mode;
>  	rc =3D 0;
>  out:
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f58cf01f8d2c..ce4a66865db3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -197,6 +197,22 @@ static ssize_t mode_store(struct device *dev, struc=
t device_attribute *attr,
>  		mode =3D CXL_DECODER_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode =3D CXL_DECODER_RAM;
> +	else if (sysfs_streq(buf, "dc0"))
> +		mode =3D CXL_DECODER_DC0;
> +	else if (sysfs_streq(buf, "dc1"))
> +		mode =3D CXL_DECODER_DC1;
> +	else if (sysfs_streq(buf, "dc2"))
> +		mode =3D CXL_DECODER_DC2;
> +	else if (sysfs_streq(buf, "dc3"))
> +		mode =3D CXL_DECODER_DC3;
> +	else if (sysfs_streq(buf, "dc4"))
> +		mode =3D CXL_DECODER_DC4;
> +	else if (sysfs_streq(buf, "dc5"))
> +		mode =3D CXL_DECODER_DC5;
> +	else if (sysfs_streq(buf, "dc6"))
> +		mode =3D CXL_DECODER_DC6;
> +	else if (sysfs_streq(buf, "dc7"))
> +		mode =3D CXL_DECODER_DC7;
>  	else
>  		return -EINVAL;
>
>
> --
> 2.41.0
>
