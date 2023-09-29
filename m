Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649287B36DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjI2Pcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Pc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:32:29 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B9B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:32:26 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-352308c0799so10516045ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1696001546; x=1696606346; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFDk6UrGoDPEHdabEQOO71J18seMwjl2IAh1g7oDA/c=;
        b=YWmNA3BOwsl7h/eWQnclgu55KU/becx+x1WyVR2tNTnYz1TKeEBUJWmqfbksAhcwlu
         hs8OhmSXRC+nnNjifFbWt7PJm6KNvqQwmf4dBlJd13RRrFv2ml40RasZgnoWY69sdRSG
         bS+BiVs7v8Me8PCqMAkqw1zRjh6HoDik/cIzr463K1qwajJkziVIXxmu2zQvrTz5mWbq
         EGkogogu7IfHvKi45nSwfek5JklSfu/Nct+HNeg8UDD2rGvGiqL3PAnkSont3+pg879X
         p9VwvCl8ycqzrUIB0oteQyNiiDvP4etM1e6NmwJqLQlkzyg4FZBh2xz75vmG3FLm+QVD
         +8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696001546; x=1696606346;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFDk6UrGoDPEHdabEQOO71J18seMwjl2IAh1g7oDA/c=;
        b=CkzjnEEG1bl2/VfcasstPQBOqNbJN0ssYP88IB8sAYvTmkfhP8RvOqiLitBR2DA5vC
         31zH4vVYBCf7yLZ+4+Jq1LXwydc/MK/yqzSE+DuWVnKJOmTP1RHnVdDaxt1IYPpHw2zB
         bN78V7DFNzrwhmMVkfw/STwC0MKJEvGNULdkSWIu9GMwq04bZp8Z+t+6HiE45WQHoPlQ
         ULgpD02RajpQNE8u60/1T1JCH/civBA76oIVWym6v27pqLg1cKKZxfmdeno4U7luY50l
         euVgvOLW4up0VwWvKIKnndrF6tjnlcwcx2tTlctORO2HhyNs/3iUnECIuDmSsF8wHGIN
         +uUA==
X-Gm-Message-State: AOJu0YzAKEBV2sHAt8XksoWYNRsSGhFpLhUd97LFiXcZtqJyGorqPySB
        wINdZGWTau0lY7PyYxQ/TGrRzF4Kk5bTrqLK/Aw=
X-Google-Smtp-Source: AGHT+IG8wiJnaAVP43/dUw8kr4Sqc7PbdDu9QqB22PtoOw81ibOowDTtW5p9Ot4FRpHfABnKY22G1w==
X-Received: by 2002:a92:d249:0:b0:352:609f:e4af with SMTP id v9-20020a92d249000000b00352609fe4afmr2132139ilg.24.1696001545989;
        Fri, 29 Sep 2023 08:32:25 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id a8-20020a637f08000000b0057d86bb613esm12393901pgd.45.2023.09.29.08.32.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2023 08:32:25 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Wyes Karny'" <wyes.karny@amd.com>
Cc:     <lenb@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230922092823.478042-1-wyes.karny@amd.com> <004501d9ed96$16af12f0$440d38d0$@telus.net> <ZRO6ofa9sHbKJBCv@BLR-5CG13462PL.amd.com>
In-Reply-To: <ZRO6ofa9sHbKJBCv@BLR-5CG13462PL.amd.com>
Subject: RE: [PATCH] tools/power turbostat: Increase the limit for fd opened
Date:   Fri, 29 Sep 2023 08:32:26 -0700
Message-ID: <001601d9f2ea$26ef3420$74cd9c60$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLdRauO63O5kGzkuYXvBkOCK34JtgIw5XPgA4q3bG+t/WnRoA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wyes,

On 2023.09.26 10:16 Wyes Karny wrote:
> On 22 Sep 13:48, Doug Smythies wrote:
> > On 2023.09.22 02:28 Wyes Karny wrote:
> >
> > > When running turbostat, a system with 512 cpus reaches the limit for
> >
> > Suggest" ... reaches the default limit for..."
> >
> > > maximum number of file descriptors that can be opened. To solve this
> > > problem, the limit is raised to 2^15, which is a large enough number.
> > >
> > > Below data is collected from AMD server systems while running turbostat:
> > >
> > > |-----------+-------------------------------|
> > > | # of cpus | # of opened fds for turbostat |
> > > |-----------+-------------------------------|
> > > | 128       | 260                           |
> > > |-----------+-------------------------------|
> > > | 192       | 388                           |
> > > |-----------+-------------------------------|
> > > | 512       | 1028                          |
> > > |-----------+-------------------------------|
> >
> > The number of open files is a function of what is being "show"ed or "hide"en.
> > They can also increase beyond the above 2 X (# of CPUs) + 4 number
> > via the --add directive.
> > >
> > > So, the new max limit would be sufficient up to 2^14 cpus.
> >
> > Well, not quiet, but the point is valid.
> >
> > Normally, I would assume that a server with a large number of
> > CPUs would have set a much higher limit of the number of open
> > files than the default. I use 131,072 and so this patch reduces the
> > maximum.
>
> I think below will fix the problem.
>
> +#define MAX_NOFILE 0x8000
> +
> +void set_rlimit(void)
> +{
> +       struct rlimit limit;
> +
> +       if(getrlimit(RLIMIT_NOFILE, &limit) < 0) {
> +               err(1, "Failed to get rlimit");
> +       }
> +
> +       if (limit.rlim_max < MAX_NOFILE)
> +               limit.rlim_max = MAX_NOFILE;
> +       if (limit.rlim_cur < MAX_NOFILE)
> +               limit.rlim_cur = MAX_NOFILE;
> +
> +       if (setrlimit(RLIMIT_NOFILE, &limit) < 0) {
> +               err(1, "Failed to set rlimit");
> +       }
> +       return;
> +}
>
> Is this looks okay to you?

Either the original or the above is fine.
I was just being nit-picky and annoying is all.
I still added a "Reviewed-by" below.

... Doug

> Thanks,
> Wyes
> >
> > Unpatched:
> > root@s19:~# cat /proc/47043/limits | grep "Max open files"
> > Max open files            131072               131072               files
> >
> > Patched:
> > root@s19:~# cat /proc/47032/limits | grep "Max open files"
> > Max open files            32768                32768                files
> >
> > Anyway:
> >
> > Reviewed-by: Doug Smythies <dsmythies@telus.net>
> > Tested-by: Doug Smythies <dsmythies@telus.net>
> >
> > >
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > ---
> > >  tools/power/x86/turbostat/turbostat.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > > index 9a10512e3407..23f1fe58289a 100644
> > > --- a/tools/power/x86/turbostat/turbostat.c
> > > +++ b/tools/power/x86/turbostat/turbostat.c
> > > @@ -6717,6 +6717,18 @@ void cmdline(int argc, char **argv)
> > >       }
> > >  }
> > >
> > > +void set_rlimit(void)
> > > +{
> > > +     struct rlimit limit;
> > > +
> > > +     limit.rlim_cur = 0x8000;
> > > +     limit.rlim_max = 0x8000;
> > > +
> > > +     if (setrlimit(RLIMIT_NOFILE, &limit) < 0) {
> > > +             err(1, "Failed to set rlimit");
> > > +     }
> > > +}
> > > +
> > >  int main(int argc, char **argv)
> > >  {
> > >       outf = stderr;
> > > @@ -6729,6 +6741,9 @@ int main(int argc, char **argv)
> > >
> > >       probe_sysfs();
> > >
> > > +     if (!getuid())
> > > +             set_rlimit();
> > > +
> > >       turbostat_init();
> > >
> > >       msr_sum_record();
> > > --
> > > 2.34.1


