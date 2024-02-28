Return-Path: <linux-kernel+bounces-84477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128486A739
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8321E1C22D62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05D200BF;
	Wed, 28 Feb 2024 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggf3sYh9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36B1CD38;
	Wed, 28 Feb 2024 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091123; cv=none; b=a25NcMYOcaq0yuEzJO7xol28z7/d0sO/750Y5GFCw1BN2hTj91aM6oAmKd0IiouepcqrfcKtc5tLpO4M7LhTFP09Kly+U47pbrvSF/TendrXN0X1Hj3siRl2ltk4xbM9XwqK/uAaZ/UqE0pJVbCb6Nlgax6hkIQ0At09cQaY0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091123; c=relaxed/simple;
	bh=mfXQ3FzHsCOGWJMna/+p/oEW7VkIC/ksgfe+TdGQ+oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IEZLZXmtDN/UNRhvcmil3aOaft757Nx/fVGlEROertE3KQSVbBXn3FlvCkFtEf4VLgbrjPX86PSfQrIczHDsQ8XsL6m3Vo+z60UVvcsGlUkhDq9rFa0Wj8Ncu6sz9ssy/L7cDIWL+fnU/pUxn9lpGadV2LTos+seDTDjWMJ8Sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggf3sYh9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709091121; x=1740627121;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mfXQ3FzHsCOGWJMna/+p/oEW7VkIC/ksgfe+TdGQ+oQ=;
  b=ggf3sYh9/W0OgBMighYWU2zhXxiWlUz0uBwem0mRMEC8Ziogecq906lv
   0L5XPV6zfSoNPylk2y0iUpYKkM3PtLoqdXVfSwKntJgVWJBpY5doC6adz
   sv7jtWjbBVPsLk7j0rS3cxQ1hin/QI4zJCWzCw2GZvrifxYdqg3bQoxwh
   23fGfiRtEgD/OoKMseudQR5etnQii/8suyGUvaIac00jMkRMFEW3Nmggz
   OW1XIkIEVVKLJY9E9+lwVseSx1ZyBuVa72CqXvKeNjKgyS4ZZp21bUbpJ
   7fdHvlL4MkyI2Oz7CJxZ9ldvvhy/Npyk7S7ZcusoztOxvsPpTlR4uwypY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7289608"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7289608"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 19:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7409366"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 19:32:00 -0800
Message-ID: <56b67440-f6a7-4266-a8be-1e312ebd9aae@linux.intel.com>
Date: Tue, 27 Feb 2024 19:31:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 9/9] tools: intel_sdsi: Add current meter support
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
 <20240228000016.1685518-10-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240228000016.1685518-10-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/24 4:00 PM, David E. Box wrote:
> Add support to read the 'meter_current' file. The display is the same as
> the 'meter_certificate', but will show the current snapshot of the
> counters.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> V2 - Set the name of the file to be opened once.
>
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 49 ++++++++++++++++----------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index a8fb6d17405f..325e1e41af1d 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -182,6 +182,7 @@ struct sdsi_dev {
>  enum command {
>  	CMD_SOCKET_INFO,
>  	CMD_METER_CERT,
> +	CMD_METER_CURRENT_CERT,
>  	CMD_STATE_CERT,
>  	CMD_PROV_AKC,
>  	CMD_PROV_CAP,
> @@ -329,13 +330,14 @@ static void get_feature(uint32_t encoding, char *feature)
>  	feature[0] = name[3];
>  }
>  
> -static int sdsi_meter_cert_show(struct sdsi_dev *s)
> +static int sdsi_meter_cert_show(struct sdsi_dev *s, bool show_current)
>  {
>  	char buf[METER_CERT_MAX_SIZE] = {0};
>  	struct bundle_encoding_counter *bec;
>  	struct meter_certificate *mc;
>  	uint32_t count = 0;
>  	FILE *cert_ptr;
> +	char *cert_fname;
Nit: I think this can be const char *
>  	int ret, size;
>  	char name[4];
>  
> @@ -345,7 +347,6 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  
>  	if (!s->regs.en_features.sdsi) {
>  		fprintf(stderr, "SDSi feature is present but not enabled.\n");
> -		fprintf(stderr, " Unable to read meter certificate\n");
>  		return -1;
>  	}
>  
> @@ -360,15 +361,17 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  		return ret;
>  	}
>  
> -	cert_ptr = fopen("meter_certificate", "r");
> +	cert_fname = show_current ? "meter_current" : "meter_certificate";
> +	cert_ptr = fopen(cert_fname, "r");
> +
>  	if (!cert_ptr) {
> -		perror("Could not open 'meter_certificate' file");
> +		fprintf(stderr, "Could not open '%s' file: %s", cert_fname, strerror(errno));
>  		return -1;
>  	}
>  
>  	size = fread(buf, 1, sizeof(buf), cert_ptr);
>  	if (!size) {
> -		fprintf(stderr, "Could not read 'meter_certificate' file\n");
> +		fprintf(stderr, "Could not read '%s' file\n", cert_fname);
>  		fclose(cert_ptr);
>  		return -1;
>  	}
> @@ -734,7 +737,7 @@ static void sdsi_free_dev(struct sdsi_dev *s)
>  
>  static void usage(char *prog)
>  {
> -	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m] [-a FILE] [-c FILE]]\n", prog);
> +	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m | -C] [-a FILE] [-c FILE]\n", prog);
>  }
>  
>  static void show_help(void)
> @@ -743,8 +746,9 @@ static void show_help(void)
>  	printf("  %-18s\t%s\n", "-l, --list",           "list available On Demand devices");
>  	printf("  %-18s\t%s\n", "-d, --devno DEVNO",    "On Demand device number");
>  	printf("  %-18s\t%s\n", "-i, --info",           "show socket information");
> -	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate");
> -	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate");
> +	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate data");
> +	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate data");
> +	printf("  %-18s\t%s\n", "-C, --meter_current",  "show live unattested meter data");
>  	printf("  %-18s\t%s\n", "-a, --akc FILE",       "provision socket with AKC FILE");
>  	printf("  %-18s\t%s\n", "-c, --cap FILE>",      "provision socket with CAP FILE");
>  }
> @@ -760,21 +764,22 @@ int main(int argc, char *argv[])
>  	int option_index = 0;
>  
>  	static struct option long_options[] = {
> -		{"akc",		required_argument,	0, 'a'},
> -		{"cap",		required_argument,	0, 'c'},
> -		{"devno",	required_argument,	0, 'd'},
> -		{"help",	no_argument,		0, 'h'},
> -		{"info",	no_argument,		0, 'i'},
> -		{"list",	no_argument,		0, 'l'},
> -		{"meter",	no_argument,		0, 'm'},
> -		{"state",	no_argument,		0, 's'},
> -		{0,		0,			0, 0 }
> +		{"akc",			required_argument,	0, 'a'},
> +		{"cap",			required_argument,	0, 'c'},
> +		{"devno",		required_argument,	0, 'd'},
> +		{"help",		no_argument,		0, 'h'},
> +		{"info",		no_argument,		0, 'i'},
> +		{"list",		no_argument,		0, 'l'},
> +		{"meter",		no_argument,		0, 'm'},
> +		{"meter_current",	no_argument,		0, 'C'},
> +		{"state",		no_argument,		0, 's'},
> +		{0,			0,			0, 0 }
>  	};
>  
>  
>  	progname = argv[0];
>  
> -	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilms", long_options,
> +	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilmCs", long_options,
>  			&option_index)) != -1) {
>  		switch (opt) {
>  		case 'd':
> @@ -790,6 +795,9 @@ int main(int argc, char *argv[])
>  		case 'm':
>  			command = CMD_METER_CERT;
>  			break;
> +		case 'C':
> +			command = CMD_METER_CURRENT_CERT;
> +			break;
>  		case 's':
>  			command = CMD_STATE_CERT;
>  			break;
> @@ -828,7 +836,10 @@ int main(int argc, char *argv[])
>  			ret = sdsi_read_reg(s);
>  			break;
>  		case CMD_METER_CERT:
> -			ret = sdsi_meter_cert_show(s);
> +			ret = sdsi_meter_cert_show(s, false);
> +			break;
> +		case CMD_METER_CURRENT_CERT:
> +			ret = sdsi_meter_cert_show(s, true);
>  			break;
>  		case CMD_STATE_CERT:
>  			ret = sdsi_state_cert_show(s);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


