Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F987D87BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjJZRoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjJZRoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:44:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3D194
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:44:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1122006b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698342270; x=1698947070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jqXzjoliREKB9p4xvOcB3bDuTodJi0Be8+f3YEh/Sg=;
        b=UuAxFZ8rojf9RiVgjodvcnx9tJZQKRPhLFg/9DS/kB0Kk29oF8RLPtNvU94j8RKkHP
         YsO8caU4GwFUCqRTV+IPIMelJY1qjMryKVZw8tkr82N6mU4KbkUEvWR5KmqciSm1inU6
         4beguz8oGtlSvj2SRzcGWpjP5yo+g7Lng7YmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342270; x=1698947070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jqXzjoliREKB9p4xvOcB3bDuTodJi0Be8+f3YEh/Sg=;
        b=nbNnP6ynnIB0ktD5VI0a3gguO8Zny8wxpfHDAV26xKqMajuUy9m5LnX+M9p6Ke0gmy
         2xyg20/DpaWdbgn9SBGTFuZnDsu8wjnxPMyreQgV8cbpT1feF4R97tKeZYyHGhdbQ2w+
         uOD41SgBZ6NSQ9CWU0FMzaKwqf+msE6gHFjsSCrnS91ulKzXpzPh3+4g70eqT/VCpczw
         O0fGjG82/TjKciEc1Gj/U8UI/DvbROLkbEGSLGF0IjKJ7t2oImBGH56l8qfyC/EFkden
         RE52fnWTl9LwNKr9CG7qibswa0HV1DWe7SmDgRgsgnfCMboZoW3Yye2XEtqJAqU62drq
         LPmw==
X-Gm-Message-State: AOJu0YyKv8IPiVxftqM8RWJJmfmeGKgK+jQwxLfvlhmvzJgXUmmkCF0b
        PI6IbrGpKFf4Q7zn4g0kpBVvbQ==
X-Google-Smtp-Source: AGHT+IFIn1TkvOQua4DcmGtNXg1tdDKwF/PYGg46B4rhYe8Xi52z8+DAf60V+s3DGKZUgN6hKkhyNw==
X-Received: by 2002:a05:6a00:2307:b0:68e:380c:6b15 with SMTP id h7-20020a056a00230700b0068e380c6b15mr200952pfh.26.1698342269673;
        Thu, 26 Oct 2023 10:44:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7952f000000b006934e7ceb79sm11469116pfp.32.2023.10.26.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:44:29 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:44:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: hpsa: replace deprecated strncpy with
 strscpy/kmemdup_nul
Message-ID: <202310261025.2FE91B6B5B@keescook>
References: <20231026-strncpy-drivers-scsi-hpsa-c-v1-1-75519d7a191b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-scsi-hpsa-c-v1-1-75519d7a191b@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:47:32AM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This whole process of 1) determining smaller length so we don't overread
> the buffer and 2) manually NUL-terminating our buffer so we can use in
> string APIs is handled implicitly by strscpy().
> 
> Therefore, a suitable replacement is `strscpy` [2] due to the fact that
> it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> For the last two strncpy() use cases in init_driver_version(), we can
> actually drop this function entirely.
> 
> Firstly, we are kmalloc()'ing driver_version. Then, we are calling
> init_driver_version() which memset's it to 0 followed by a strncpy().
> This pattern of 1) allocating memory for a string, 2) setting all bytes
> to NUL, 3) copy bytes from another string + ensure NUL-padded
> destination is just an open-coded kmemdup_nul().
> 
> The last case involves swapping kmalloc_array() for kcalloc() to give us
> a zero-filled two-element array for both old_driver_version and
> driver_version without needing the memset from init_driver_version().
> 
> Now this code is easier to read and less fragile (no more ... - 1's) or
> min length checks and now we have guaranteed NUL-termination everywhere!
> 
> Although perhaps there should be a macro for:
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/scsi/hpsa.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index af18d20f3079..3376d4614fe5 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -452,16 +452,15 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	int status, len;
> +	int status;
>  	struct ctlr_info *h;
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	char tmpbuf[10];
>  
>  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>  		return -EACCES;
> -	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
> -	strncpy(tmpbuf, buf, len);
> -	tmpbuf[len] = '\0';
> +	strscpy(tmpbuf, buf, count);

This is wrong -- "count" isn't the size of tmpbuf -- it's the size of
the source, i.e.  strlen(buf).

> +
>  	if (sscanf(tmpbuf, "%d", &status) != 1)
>  		return -EINVAL;

And this is immediately using the tmpbuf for getting an int. All of this
should be replaced by kstrtoint().

>  	h = shost_to_hba(shost);
> @@ -476,16 +475,15 @@ static ssize_t host_store_raid_offload_debug(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	int debug_level, len;
> +	int debug_level;
>  	struct ctlr_info *h;
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	char tmpbuf[10];
>  
>  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>  		return -EACCES;
> -	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
> -	strncpy(tmpbuf, buf, len);
> -	tmpbuf[len] = '\0';
> +	strscpy(tmpbuf, buf, count);
> +
>  	if (sscanf(tmpbuf, "%d", &debug_level) != 1)
>  		return -EINVAL;

Same thing here.

>  	if (debug_level < 0)
> @@ -7234,24 +7232,19 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> -static void init_driver_version(char *driver_version, int len)
> -{
> -	memset(driver_version, 0, len);
> -	strncpy(driver_version, HPSA " " HPSA_DRIVER_VERSION, len - 1);
> -}
> -
>  static int write_driver_ver_to_cfgtable(struct CfgTable __iomem *cfgtable)
>  {
>  	char *driver_version;
>  	int i, size = sizeof(cfgtable->driver_version);
>  
> -	driver_version = kmalloc(size, GFP_KERNEL);
> +	driver_version = kmemdup_nul(HPSA " " HPSA_DRIVER_VERSION, size,
> +				     GFP_KERNEL);

"size" isn't the length of the string here, so this results in an
over-read from the .data segment:

drivers/scsi/hpsa.c:#define HPSA "hpsa"
drivers/scsi/hpsa.c:#define HPSA_DRIVER_VERSION "3.4.20-200"

strlen(HSPA " " HPSA_DRIVER_VERSION) == 15 (16 with %NUL terminator)

sizeof(cfgtable->driver_version) == 32:

struct CfgTable {
	...
        u8              driver_version[32];

>  	if (!driver_version)
>  		return -ENOMEM;
>  
> -	init_driver_version(driver_version, size);
>  	for (i = 0; i < size; i++)
>  		writeb(driver_version[i], &cfgtable->driver_version[i]);

And then this will write garbage out to the driver for the 16 bytes
following the string... :(

Also, this thing is doing an alloc/free for a tiny string. That can just
be on the stack:

	char driver_version[sizeof(cfgtable->driver_version)] = HPSA " " HPSA_DRIVER_VERSION;

No alloc/free, no strscpy, easy easy. (Since the string is explicitly
sized, the remaining space will be zero-initialized.)


> +
>  	kfree(driver_version);
>  	return 0;
>  }
> @@ -7271,7 +7264,7 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
>  	char *driver_ver, *old_driver_ver;
>  	int rc, size = sizeof(cfgtable->driver_version);
>  
> -	old_driver_ver = kmalloc_array(2, size, GFP_KERNEL);
> +	old_driver_ver = kcalloc(2, size, GFP_KERNEL);
>  	if (!old_driver_ver)
>  		return -ENOMEM;
>  	driver_ver = old_driver_ver + size;
> @@ -7279,7 +7272,7 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
>  	/* After a reset, the 32 bytes of "driver version" in the cfgtable
>  	 * should have been changed, otherwise we know the reset failed.
>  	 */
> -	init_driver_version(old_driver_ver, size);
> +	strscpy(old_driver_ver, HPSA " " HPSA_DRIVER_VERSION, size);
>  	read_driver_ver_from_cfgtable(cfgtable, driver_ver);
>  	rc = !memcmp(driver_ver, old_driver_ver, size);
>  	kfree(old_driver_ver);

This function is also wild -- it's allocating 2 strings (but at the same
time, and using offsets to get to them), and again -- why? Just use the
stack for 64 bytes:

	char driver_ver[sizeof(cfgtable->driver_version)] = "";
	char old_driver_ver[sizeof(cfgtable->driver_version)] = HPSA " " HPSA_DRIVER_VERSION;

-Kees

-- 
Kees Cook
