Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060E7859B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjHWNtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjHWNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:49:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2971CDF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:49:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c3726cc45so3190217f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692798560; x=1693403360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzy9s2VPfqyH0iLc++3NxHQHmMLO7Tr1t0irsXrk0Lc=;
        b=cdrK/glh4WmCt5YVsalb6hzH+SDGqK8+IFaaR9wheZr1NZSkYt27Vhi4xHEjvWCCJg
         wDiSqYbNfoYfL9JIQF/QGPgRyrgz6niIsdnLfHxzKVvfWaPQUgTnkLcnbc+1lv9vTGJn
         JoSPwEfiwb2XaxqfnuC+ju3ATQLX5p94z6nTP1f62wRK88Zss7ZD+KwW1UM80BGKTlZN
         Iag7zoYbswYD27S25IXio3Lnb/q3ICkVk/bfgrLlth9CTIOXHm5hOYBhasH6ZTJctNGW
         pNPHjbIXK+E/M9yIAEeGQAzqBPVnC1BmwoJ6BIWJz1rEszIqLsgXx48+pVwObTgV24Jg
         0iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798560; x=1693403360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzy9s2VPfqyH0iLc++3NxHQHmMLO7Tr1t0irsXrk0Lc=;
        b=NX1PO9R3tLGXJ29CwG46W7oharQuC2mQlGeVkLHWtJcIRt+Sr2i35xm71DDPcrCvTz
         x74VXBEOvPeR5gZrHwGSrnrRjKoDC5lGLPEjrU5yxbW5K8gG6jCr8FzRYj852OsTrLrs
         ng/Gpl75f4pRn9qcnfk3PNUqRrvUnGFdGMUw7SFKdDnso02g4wH0ml8gGBCFj4zc7Eug
         +fnp6uQPBXiAAm2BtX3H7qzsNIJgvppVjtV4KQEl9/dx17FJe09yLlWOY8P70NN/aArU
         7TSZNZItNbOh4kOmqCw4EydSkHVxVLkTb7yggKjUvEmP+e1aO/uvDn/bbUAJ2yfu7JpD
         48yw==
X-Gm-Message-State: AOJu0YwdEwZ4KBOJ9WCCM966gjPqGJ1LQRHzMAaCpHUb8kYxD6tL9Eq2
        RUhiLQBmjzMwXymG48TXGuoJTA==
X-Google-Smtp-Source: AGHT+IELx/2cOcy05u1WovM2LFGDoFigSu7YBIYjmztU2X7o3deEDpmB8I4t1jQO5u9Am7JGAuDdxg==
X-Received: by 2002:adf:fd04:0:b0:319:6e43:7f6a with SMTP id e4-20020adffd04000000b003196e437f6amr9913793wrr.30.1692798560287;
        Wed, 23 Aug 2023 06:49:20 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d638e000000b0031ae2a7adb5sm18607451wru.85.2023.08.23.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:49:19 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:49:17 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation
 reports
Message-ID: <ZOYOXTsveEhPCHq2@vermeer>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, Aug 14, 2023 at 12:43:21AM -0700, Dan Williams wrote:
> One of the common operations of a TSM (Trusted Security Module) is to
> provide a way for a TVM (confidential computing guest execution
> environment) to take a measurement of its launch state, sign it and
> submit it to a verifying party. Upon successful attestation that
> verifies the integrity of the TVM additional secrets may be deployed.
> The concept is common across TSMs, but the implementations are
> unfortunately vendor specific. While the industry grapples with a common
> definition of this attestation format [1], Linux need not make this
> problem worse by defining a new ABI per TSM that wants to perform a
> similar operation. The current momentum has been to invent new ioctl-ABI
> per TSM per function which at best is an abdication of the kernel's
> responsibility to make common infrastructure concepts share common ABI.
> 
> The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> more, is to define a sysfs interface to retrieve the TSM-specific blob.
> 
>     echo $hex_encoded_userdata_plus_nonce > /sys/class/tsm/tsm0/inhex
>     hexdump /sys/class/tsm/tsm0/outblob

My concern with that interface is that one could easily get an
attestation report with a nonce set by another userspace component or
thread. I realize there is a generation counter to detect if a
configuration changed between the caller's last config setting and the
report it got, but I think that this shows that this may not be the best
interface. IMHO an attestation report request from userspace should be
an atomic call that includes multiple platform independent attibutes
like e.g. an attestation nonce.

> This approach later allows for the standardization of the attestation
> blob format without needing to change the Linux ABI. Until then, the
> format of 'outblob' is determined by the parent device for 'tsm0'.
> 
> The expectation is that this is a boot time exchange that need not be
> regenerated, 

This works well with the encrypted boot disk that's decrypted through
attestation use-case, but this is just one use case. Although I don't
expect attestation requests to be frequent, we should not assume this is
only a boot time operation. Not only it can happen after the guest is
fully booted, but it can also happen multiple times. An attestation flow
where a guest gets an attestation token back from a validated report is
something we'd want to support. Those token's validity are time limited,
and userspace would want to regenerate a report, with a fresh,
attestation service provided nonce.
Another thing to keep in mind is that an attestation report could be
amended by userspace itself, for TEE that support runtime measurement
(The RTMR things...). So the TVM measurement itself could change during
the lifecycle of a TVM.

> making it amenable to a sysfs interface. In case userspace
> does try to generate multiple attestation reports it includes conflict
> detection so userspace can be sure no other thread changed the
> parameters from its last configuration step to the blob retrieval.
> 
> TSM specific options are encoded as 'extra' attributes on the TSM device
> with the expectation that vendors reuse the same options for similar
> concepts. The current options are defined by SEV-SNP's need for a
> 'privilege level' concept (VMPL), and the option to retrieve a
> certificate chain in addition to the attestation report ("extended"
> format).
> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tsm |   47 +++++
>  MAINTAINERS                               |    8 +
>  drivers/virt/coco/Kconfig                 |    4 
>  drivers/virt/coco/Makefile                |    1 
>  drivers/virt/coco/tdx-guest/Kconfig       |    1 
>  drivers/virt/coco/tsm.c                   |  290 +++++++++++++++++++++++++++++
>  include/linux/tsm.h                       |   45 +++++
>  7 files changed, 396 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>  create mode 100644 drivers/virt/coco/tsm.c
>  create mode 100644 include/linux/tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> new file mode 100644
> index 000000000000..37017bde626d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -0,0 +1,47 @@
> +What:		/sys/class/tsm/tsm0/inhex
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org

Did you mean linux-coco@ ?


> +Description:
> +		(RW) Hex encoded userdata to be included in the attestation
> +		report. For replay protection this should include a nonce, but
> +		the kernel does not place any restrictions on the content.
> +
> +What:		/sys/class/tsm/tsm0/outblob
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Binary attestation report generated from @inhex translated
> +		to binary and any options. The format of the report is vendor
> +		specific and determined by the parent device of 'tsm0'.
> +
> +What:		/sys/class/tsm/tsm0/generation
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The value in this attribute increments each time @inhex or
> +		any option is written. Userspace can detect conflicts by
> +		checking generation before writing to any attribute and making
> +		sure the number of writes matches expectations after reading
> +		@outblob.

One note here is that an attestation userspace thread could get an
invalid counter although the report is valid, if e.g. a separate thread
modified a config between the first thread report generation and it
reading the counter back. So an attestation report generating thread
could get false negatives with that interface.

Cheers,
Samuel.

