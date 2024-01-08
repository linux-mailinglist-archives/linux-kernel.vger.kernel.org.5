Return-Path: <linux-kernel+bounces-19755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E18272DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B8F1C217AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181FA4C3DC;
	Mon,  8 Jan 2024 15:20:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8015103A;
	Mon,  8 Jan 2024 15:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1797C43391;
	Mon,  8 Jan 2024 15:20:19 +0000 (UTC)
Date: Mon, 8 Jan 2024 10:21:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andy@kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing histograms: Simplify parse_actions() function
Message-ID: <20240108102115.43464fd6@gandalf.local.home>
In-Reply-To: <CAHp75VcsV8t2-6GB24Rz003B2JSAEOBjWD7B7FjEXuCQhkJ5pQ@mail.gmail.com>
References: <20240107203258.37e26d2b@gandalf.local.home>
	<CAHp75VcsV8t2-6GB24Rz003B2JSAEOBjWD7B7FjEXuCQhkJ5pQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2024 10:32:14 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jan 8, 2024 at 3:31=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > The parse_actions() function uses 'len =3D str_has_prefix()' to test wh=
ich
> > action is in the string being parsed. But then it goes and repeats the
> > logic for each different action. This logic can be simplified and
> > duplicate code can be removed as 'len' contains the length of the found
> > prefix which should be used for all actions. =20
>=20
> > Link: https://lore.kernel.org/all/20240107112044.6702cb66@gandalf.local=
.home/
> >
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org> =20
>=20
> If you want Link to be formally a tag, you should drop the following
> blank line.

The link is for humans not for parsers.

>=20
>=20
> > +               if ((len =3D str_has_prefix(str, "onmatch(")))
> > +                       hid =3D HANDLER_ONMATCH;
> > +               else if ((len =3D str_has_prefix(str, "onmax(")))
> > +                       hid =3D HANDLER_ONMAX;
> > +               else if ((len =3D str_has_prefix(str, "onchange(")))
> > +                       hid =3D HANDLER_ONCHANGE; =20
>=20
> The repeating check for ( might be moved out as well after this like
>=20
>   if (str[len] !=3D '(') {
>     // not sure if you need data to be assigned here as well
>     ret =3D -EINVAL;
>     ...
>   }
>=20

Not sure how that makes it any better. It adds more code. I could start
with checking the "on" before checking for "match", "max" and "change", but
that just makes it more complex.

-- Steve


