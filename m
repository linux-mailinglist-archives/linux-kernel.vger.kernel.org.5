Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D37E194E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKFEB2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 23:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFEB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:01:26 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A4F2;
        Sun,  5 Nov 2023 20:01:23 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so3987426a12.0;
        Sun, 05 Nov 2023 20:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699243283; x=1699848083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq2PaTTm8ScGQcrNNQNUmc8/MIWUPOH3hzTm7x5JKOQ=;
        b=ZqIpafNkphcCtZJk6Nh4nHOnHiaLsjCixaQEt+YGDB1+NGPfg2R+Ke2ozVrSp5FrPB
         hSN+u2vvedBsHlGp+Noq9opHcmuelFts7n6TUH1L+SWGgONxu9aPnLDco8WEuruue3gi
         y8Rov/AXkJ4B6SBIVrXJsPKoexqkj1Fu2IrY+HSt2HHtpmt+SF8AvnMA7gxGxOlQMrGM
         tTNIcAoLNehA4dBa78H5gPBLR1FkX+gOwHx72Mxu2/UnElzegmzbo1r3pdRXH7xk1nt2
         g/nsmHwtlni+ZvkOsNRnHsBy3SnpznSjJDErOctZqXGsWLBRvi0RK1Tmgw6QnB9dTG0x
         jefw==
X-Gm-Message-State: AOJu0Yyqu1l6+0He4eamhC71awzhkAeh0mpKOelK9F1T2YYQ9rZjIE+8
        z9Cg7YTs9JSl8YV9+JWiZdPaI1+a5hGCCpw687I=
X-Google-Smtp-Source: AGHT+IFVVvsHF0g1qdZo3Pd1+rjvDCAHcHZpddqpbuPpZDa4QrqCX0+wqQBUh1xhFPIo24eO5BTm9k9+irWKzv8iLao=
X-Received: by 2002:a17:90b:3ec9:b0:27d:1369:515e with SMTP id
 rm9-20020a17090b3ec900b0027d1369515emr13333388pjb.22.1699243283129; Sun, 05
 Nov 2023 20:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012035111.676789-9-namhyung@kernel.org>
 <20231105180732.f3483276b09360267e6d6fbb@kernel.org>
In-Reply-To: <20231105180732.f3483276b09360267e6d6fbb@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 20:01:12 -0800
Message-ID: <CAM9d7cjT5JB9Z_-Wa4mxUVzRsaRNiBCpW+rQ7WyJmt82+5+amw@mail.gmail.com>
Subject: Re: [PATCH 08/48] perf dwarf-aux: Factor out __die_get_typename()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sun, Nov 5, 2023 at 1:07 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 11 Oct 2023 20:50:31 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > The __die_get_typename() is to get the name of the given DIE in C-style
> > type name.  The difference from the die_get_typename() is that it does
> > not retrieve the DW_AT_type and use the given DIE directly.  This will
> > be used when users know the type DIE already.
>
> Hmm, I would rather like to have another name for this function.
> What about 'die_get_typename_from_type()' ?

Ok.

> >
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++-----------
> >  tools/perf/util/dwarf-aux.h |  3 +++
> >  2 files changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 652e6e7368a2..5bb05c84d249 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1051,32 +1051,28 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
> >  }
> >
> >  /**
> > - * die_get_typename - Get the name of given variable DIE
> > - * @vr_die: a variable DIE
> > + * __die_get_typename - Get the name of given type DIE
> > + * @type: a type DIE
> >   * @buf: a strbuf for result type name
> >   *
> > - * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
> > + * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
> >   * and Return -ENOENT if failed to find type name.
> >   * Note that the result will stores typedef name if possible, and stores
> >   * "*(function_type)" if the type is a function pointer.
> >   */
> > -int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
> > +int __die_get_typename(Dwarf_Die *type, struct strbuf *buf)
>
> Could you use 'type_die' instead of 'type' if it is exposed?

Will change, thanks for your review!
Namhyung


> >  {
> > -     Dwarf_Die type;
> >       int tag, ret;
> >       const char *tmp = "";
> >
> > -     if (__die_get_real_type(vr_die, &type) == NULL)
> > -             return -ENOENT;
> > -
> > -     tag = dwarf_tag(&type);
> > +     tag = dwarf_tag(type);
> >       if (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)
> >               tmp = "*";
> >       else if (tag == DW_TAG_subroutine_type) {
> >               /* Function pointer */
> >               return strbuf_add(buf, "(function_type)", 15);
> >       } else {
> > -             const char *name = dwarf_diename(&type);
> > +             const char *name = dwarf_diename(type);
> >
> >               if (tag == DW_TAG_union_type)
> >                       tmp = "union ";
> > @@ -1089,7 +1085,7 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
> >               /* Write a base name */
> >               return strbuf_addf(buf, "%s%s", tmp, name ?: "");
> >       }
> > -     ret = die_get_typename(&type, buf);
> > +     ret = die_get_typename(type, buf);
> >       if (ret < 0) {
> >               /* void pointer has no type attribute */
> >               if (tag == DW_TAG_pointer_type && ret == -ENOENT)
> > @@ -1100,6 +1096,26 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
> >       return strbuf_addstr(buf, tmp);
> >  }
> >
> > +/**
> > + * die_get_typename - Get the name of given variable DIE
> > + * @vr_die: a variable DIE
> > + * @buf: a strbuf for result type name
> > + *
> > + * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
> > + * and Return -ENOENT if failed to find type name.
> > + * Note that the result will stores typedef name if possible, and stores
> > + * "*(function_type)" if the type is a function pointer.
> > + */
> > +int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
> > +{
> > +     Dwarf_Die type;
> > +
> > +     if (__die_get_real_type(vr_die, &type) == NULL)
> > +             return -ENOENT;
> > +
> > +     return __die_get_typename(&type, buf);
> > +}
> > +
> >  /**
> >   * die_get_varname - Get the name and type of given variable DIE
> >   * @vr_die: a variable DIE
> > diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> > index b6f430730bd1..574405c57d3b 100644
> > --- a/tools/perf/util/dwarf-aux.h
> > +++ b/tools/perf/util/dwarf-aux.h
> > @@ -116,6 +116,9 @@ Dwarf_Die *die_find_variable_at(Dwarf_Die *sp_die, const char *name,
> >  Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
> >                          Dwarf_Die *die_mem);
> >
> > +/* Get the name of given type DIE */
> > +int __die_get_typename(Dwarf_Die *type, struct strbuf *buf);
> > +
> >  /* Get the name of given variable DIE */
> >  int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf);
> >
> > --
> > 2.42.0.655.g421f12c284-goog
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
