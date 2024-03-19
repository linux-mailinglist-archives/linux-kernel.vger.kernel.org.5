Return-Path: <linux-kernel+bounces-107936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FD18803C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2371C22C16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A352C68F;
	Tue, 19 Mar 2024 17:41:21 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B93A1CD24;
	Tue, 19 Mar 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870081; cv=none; b=a4mSFD3Hgsu25rhp+z7E8gcnermnHowcyTTkgkhARJXzicVvEDsVlRlnwp+xtyUFD6yFbi4g6XUg4qgSjW4aAbtQJoVF+2JIW/9TTQKZE20HeNqNfYTD3E3qZE2fljmUdvsyINk3QNh1vMZPkrNVOObChWAhKHJMG05N7Lnx47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870081; c=relaxed/simple;
	bh=TvNDMnssTfhV6421IEswYDmR42C5dMtYiJ1mEVtIdFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zblm+ptiiClJHuIw5+mHpgVV5tJlF686eZSAcyE7VQ2jqZBZEYbKwYMY8AgLOjWbtAuC5ymaPTeahfjbZyWTbKXq6CD9SFSSp2kkysH8PaxC+BWUEDEDmgo/TXGWhzCU1WCEg5tI/3Vufct0BsJYwpZDrYeu41LQhbHYTybDnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so4449612a12.1;
        Tue, 19 Mar 2024 10:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870079; x=1711474879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CSPbX1Xd5Cwgf7z/rJxAM7//MMvTw7xggH/ih20s0w=;
        b=GE0PBODechFNjpKGyi8XgIsPMXnobEgCQHESwgey+zh9MjkoD5Jet6cdCgFGNXFH/0
         BDXXudBFiZUSdvkRn1EiTqvGkyuNo3ooVj/1xzypCn2xxMrrt93ECgnNEjjpfZ4rxjWk
         LFw2VL6Fr7PHoSs7ZUsbYczWACH7Or8m4sMTxgtUhonWZy49eupYdqbTpCnpqqeIRUxU
         fWD+fwupNbRLcbhEDDlUUwTdaNjFk1osKsvr+rbZH7eycu4mtX9BKnHDjGPwXgNUpJmv
         SrqOy/m/X0oK2kM+Pt8meBMq74F1vP4XWoDKXo2/oPajxpFNjklGKE3gK5N1Hhbipq8f
         0Cwg==
X-Forwarded-Encrypted: i=1; AJvYcCXQSTGsDcsXTS0fF1U9L9uJYTf8I/eauzgy6DEMy/Z8sYpMUYZhYiLLxXSjVG9KEUJzWPZHM5J1tMl9HapPz+rErBio/88rfkGRxSLKU5bJM8EIWmqZWgnr75wEoeyHbYYDkKc3aYAgNmBRLMP+MgyytA+yNbgdU8VxSzHXxBee2WhTP3WGNqCp5KMP2uepzFPTbcyvdRkD2Kk+SHV+dGIp9oYQb/9lpwWiNXt7tJPPHwEPsg==
X-Gm-Message-State: AOJu0YwQ8+tJ293zkUWtw8p63wUOojoLJdP62ewz/eeGxMC+LC51Tt26
	7CmRR1WUBcYz9ZvF/B3iz8XNUs8zIfM3B7/ya1qz3eBvhnOdDJLksc7wvy+XJ8rX3GgqFgTsALy
	a47KJNPdIPxPHyLE3DRlkmSS2rPY=
X-Google-Smtp-Source: AGHT+IHi2zwxZ4xqtPCLlLZ4t+tiOn+XGM+cya5gsIunXJFljLd6GzwsiT+Ab+2pTzUUa4FtbnDiKrPu8OC1UInKw1g=
X-Received: by 2002:a17:90a:e50d:b0:29b:ccb4:a250 with SMTP id
 t13-20020a17090ae50d00b0029bccb4a250mr11108973pjy.16.1710870078736; Tue, 19
 Mar 2024 10:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-4-namhyung@kernel.org>
 <ZfmZNp1DaKYZCwyf@x1>
In-Reply-To: <ZfmZNp1DaKYZCwyf@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 10:41:06 -0700
Message-ID: <CAM9d7cg50Smf7A-ihrxO9Lw5RmXf56NahL7U13qDJHtCL8C=LQ@mail.gmail.com>
Subject: Re: [PATCH 03/23] perf dwarf-aux: Handle type transfer for memory access
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 18, 2024 at 10:50:55PM -0700, Namhyung Kim wrote:
> > We want to track type states as instructions are executed.  Each
> > instruction can access compound types like struct or union and load/
> > store its members to a different location.
> >
> > The die_deref_ptr_type() is to find a type of memory access with a
> > pointer variable.  If it points to a compound type like struct, the
> > target memory is a member in the struct.  The access will happen
> > with an offset indicating which member it refers.  Let's follow the
> > DWARF info to figure out the type of the pointer target.
> >
> > For example, say we have the following code.
> >
> >   struct foo {
> >     int a;
> >     int b;
> >   };
> >
> >   struct foo *p =3D malloc(sizeof(*p));
> >   p->b =3D 0;
> >
> > The last pointer access should produce x86 asm like below:
> >
> >   mov  0x0, 4(%rbx)
> >
> > And we know %rbx register has a pointer to struct foo.  Then offset 4
> > should return the debug info of member 'b'.
> >
> > Also variables of compound types can be accessed directly without a
> > pointer.  The die_get_member_type() is to handle a such case.
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/dwarf-aux.c | 110 ++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/dwarf-aux.h |   6 ++
> >  2 files changed, 116 insertions(+)
> >
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 785aa7a3d725..cd9364d296b6 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1838,3 +1838,113 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Add=
r pc, Dwarf_Die **scopes)
> >       *scopes =3D data.scopes;
> >       return data.nr;
> >  }
> > +
> > +static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
> > +{
> > +     Dwarf_Die type_die;
> > +     Dwarf_Word size, loc;
> > +     Dwarf_Word offset =3D (long)arg;
> > +     int tag =3D dwarf_tag(die_mem);
> > +
> > +     if (tag !=3D DW_TAG_member)
> > +             return DIE_FIND_CB_SIBLING;
> > +
> > +     /* Unions might not have location */
> > +     if (die_get_data_member_location(die_mem, &loc) < 0)
> > +             loc =3D 0;
> > +
> > +     if (offset =3D=3D loc)
> > +             return DIE_FIND_CB_END;
> > +
> > +     die_get_real_type(die_mem, &type_die);
>
> Don't we have to check that the type_die was initialized? From what I
> can see there is the possibility it isn't:

Right, it might return NULL if the entry doesn't have a valid
DW_AT_type.  I'll check the return value and skip.

Thanks,
Namhyung

>
>   Dwarf_Die type_die;
>   die_get_real_type(die_mem, &type_die);
>         do {
>                 vr_die =3D __die_get_real_type(vr_die, die_mem);
>         } while (vr_die && dwarf_tag(vr_die) =3D=3D DW_TAG_typedef);
>
>         return vr_die;
>
>     static Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *d=
ie_mem)
>
>         do {
>                 vr_die =3D die_get_type(vr_die, die_mem);
>                 if (!vr_die)
>                         break;
>
>    Dwarf_Die *die_get_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
>
>         Dwarf_Attribute attr;
>
>         if (dwarf_attr_integrate(vr_die, DW_AT_type, &attr) &&
>             dwarf_formref_die(&attr, die_mem))
>                 return die_mem;
>         else
>                 return NULL;
>   }
>
> > +     if (dwarf_aggregate_size(&type_die, &size) < 0)
> > +             size =3D 0;
> > +
> > +     if (loc < offset && offset < (loc + size))
> > +             return DIE_FIND_CB_END;
> > +
> > +     return DIE_FIND_CB_SIBLING;
> > +}
> > +
> > +/**
> > + * die_get_member_type - Return type info of struct member
> > + * @type_die: a type DIE
> > + * @offset: offset in the type
> > + * @die_mem: a buffer to save the resulting DIE
> > + *
> > + * This function returns a type of a member in @type_die where it's lo=
cated at
> > + * @offset if it's a struct.  For now, it just returns the first match=
ing
> > + * member in a union.  For other types, it'd return the given type dir=
ectly
> > + * if it's within the size of the type or NULL otherwise.
> > + */
> > +Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
> > +                            Dwarf_Die *die_mem)
> > +{
> > +     Dwarf_Die *member;
> > +     Dwarf_Die mb_type;
> > +     int tag;
> > +
> > +     tag =3D dwarf_tag(type_die);
> > +     /* If it's not a compound type, return the type directly */
> > +     if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_union_type)=
 {
> > +             Dwarf_Word size;
> > +
> > +             if (dwarf_aggregate_size(type_die, &size) < 0)
> > +                     size =3D 0;
> > +
> > +             if ((unsigned)offset >=3D size)
> > +                     return NULL;
> > +
> > +             *die_mem =3D *type_die;
> > +             return die_mem;
> > +     }
> > +
> > +     mb_type =3D *type_die;
> > +     /* TODO: Handle union types better? */
> > +     while (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG_unio=
n_type) {
> > +             member =3D die_find_child(&mb_type, __die_find_member_off=
set_cb,
> > +                                     (void *)(long)offset, die_mem);
> > +             if (member =3D=3D NULL)
> > +                     return NULL;
> > +
> > +             if (die_get_real_type(member, &mb_type) =3D=3D NULL)
> > +                     return NULL;
> > +
> > +             tag =3D dwarf_tag(&mb_type);
> > +
> > +             if (tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG=
_union_type) {
> > +                     Dwarf_Word loc;
> > +
> > +                     /* Update offset for the start of the member stru=
ct */
> > +                     if (die_get_data_member_location(member, &loc) =
=3D=3D 0)
> > +                             offset -=3D loc;
> > +             }
> > +     }
> > +     *die_mem =3D mb_type;
> > +     return die_mem;
> > +}
> > +
> > +/**
> > + * die_deref_ptr_type - Return type info for pointer access
> > + * @ptr_die: a pointer type DIE
> > + * @offset: access offset for the pointer
> > + * @die_mem: a buffer to save the resulting DIE
> > + *
> > + * This function follows the pointer in @ptr_die with given @offset
> > + * and saves the resulting type in @die_mem.  If the pointer points
> > + * a struct type, actual member at the offset would be returned.
> > + */
> > +Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
> > +                           Dwarf_Die *die_mem)
> > +{
> > +     Dwarf_Die type_die;
> > +
> > +     if (dwarf_tag(ptr_die) !=3D DW_TAG_pointer_type)
> > +             return NULL;
> > +
> > +     if (die_get_real_type(ptr_die, &type_die) =3D=3D NULL)
> > +             return NULL;
> > +
> > +     return die_get_member_type(&type_die, offset, die_mem);
> > +}
> > diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> > index cd171b06fd4c..16c916311bc0 100644
> > --- a/tools/perf/util/dwarf-aux.h
> > +++ b/tools/perf/util/dwarf-aux.h
> > @@ -144,6 +144,12 @@ struct die_var_type {
> >       int offset;
> >  };
> >
> > +/* Return type info of a member at offset */
> > +Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_=
Die *die_mem);
> > +
> > +/* Return type info where the pointer and offset point to */
> > +Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Di=
e *die_mem);
> > +
> >  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
> >
> >  /* Get byte offset range of given variable DIE */
> > --
> > 2.44.0.291.gc1ea87d7ee-goog

