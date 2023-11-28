Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01597FAFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjK1BsG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 20:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1BsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:48:04 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C213138;
        Mon, 27 Nov 2023 17:48:07 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b837d974ecso3095293b6e.2;
        Mon, 27 Nov 2023 17:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701136086; x=1701740886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVr3F2hxQwUzP61DpYsFkJ3ETcJcTqVqqeZTUprliR8=;
        b=xUTX/z2Sw2rW1o/yVrd0h2yysRxMsGTGGdmgLoNCwfyaAAjnPj0nzrAPcvnAR+iERr
         EKyMNxR2RwZ/uwZvO2CemnjXOUauaE3YMjme9f2e5aPTqac6z81vKlsuNC4XkvPa64vq
         ljhfNGdhAM31tThyQsCOWBPJVWexyxLOcxEn1DpOc9DbjkMQSBAq2PrNsQihn+0Kua0l
         P2nbIEMhpaYrX2IbnTFPZamHb/kan2ReIUoajQQ33DLxqmxlUoTMUmY9rPoVnT8JjgX8
         EGTPgcp76JMpSWqKSVCSUj4DoaL22jvk6Tj+IQr9zDlgTI0ox5OIAmyvPTACd5iWMRzH
         Y77A==
X-Gm-Message-State: AOJu0YxeTV17EpdiEx9k8HV2eH9sBcwyyTkCx54ustoSP38FivdUS+lp
        rzEKbYeIapA6Qr5RAPFjjWv074ZL0irctc7eO5k=
X-Google-Smtp-Source: AGHT+IGvxNlGukeQgZNcXeGDTi+TJJ93S20Hj8BOi49VO0yFr6+9IKAW+lVKp5+sV6kNLbcACqkrXXBiDVMzccFfCUw=
X-Received: by 2002:a05:6871:296:b0:1fa:3b7d:1573 with SMTP id
 i22-20020a056871029600b001fa3b7d1573mr8676008oae.7.1701136086592; Mon, 27 Nov
 2023 17:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20231003050751.525932-1-wyes.karny@amd.com>
In-Reply-To: <20231003050751.525932-1-wyes.karny@amd.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 27 Nov 2023 20:47:55 -0500
Message-ID: <CAJvTdKnE4RW7fkHX2r6MvtrC80ynMazgP90KGi7Yump-s3-09g@mail.gmail.com>
Subject: Re: [PATCH v2] tools/power turbostat: Increase the limit for fd opened
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied

Thanks Wyes!

On Tue, Oct 3, 2023 at 1:08 AM Wyes Karny <wyes.karny@amd.com> wrote:
>
> When running turbostat, a system with 512 cpus reaches the limit for
> maximum number of file descriptors that can be opened. To solve this
> problem, the limit is raised to 2^15, which is a large enough number.
>
> Below data is collected from AMD server systems while running turbostat:
>
> |-----------+-------------------------------|
> | # of cpus | # of opened fds for turbostat |
> |-----------+-------------------------------|
> | 128       | 260                           |
> |-----------+-------------------------------|
> | 192       | 388                           |
> |-----------+-------------------------------|
> | 512       | 1028                          |
> |-----------+-------------------------------|
>
> So, the new max limit would be sufficient up to 2^14 cpus (but this
> also depends on how many counters are enabled).
>
> Reviewed-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
> v1 -> v2:
> - Take care of already higher rlim_max, rlim_curr
> - Minor tweak in commit text
>
>  tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9a10512e3407..1563a0ae7e4c 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -53,6 +53,8 @@
>  #define        NAME_BYTES 20
>  #define PATH_BYTES 128
>
> +#define MAX_NOFILE 0x8000
> +
>  enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
>  enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
>  enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
> @@ -6717,6 +6719,22 @@ void cmdline(int argc, char **argv)
>         }
>  }
>
> +void set_rlimit(void)
> +{
> +       struct rlimit limit;
> +
> +       if (getrlimit(RLIMIT_NOFILE, &limit) < 0)
> +               err(1, "Failed to get rlimit");
> +
> +       if (limit.rlim_max < MAX_NOFILE)
> +               limit.rlim_max = MAX_NOFILE;
> +       if (limit.rlim_cur < MAX_NOFILE)
> +               limit.rlim_cur = MAX_NOFILE;
> +
> +       if (setrlimit(RLIMIT_NOFILE, &limit) < 0)
> +               err(1, "Failed to set rlimit");
> +}
> +
>  int main(int argc, char **argv)
>  {
>         outf = stderr;
> @@ -6729,6 +6747,9 @@ int main(int argc, char **argv)
>
>         probe_sysfs();
>
> +       if (!getuid())
> +               set_rlimit();
> +
>         turbostat_init();
>
>         msr_sum_record();
> --
> 2.34.1
>


-- 
Len Brown, Intel
