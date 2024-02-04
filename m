Return-Path: <linux-kernel+bounces-51376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4265848A5A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956061C234F4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA7138E;
	Sun,  4 Feb 2024 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTPnHY06"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D05EBE;
	Sun,  4 Feb 2024 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707012210; cv=none; b=DzJoNHfqx761nt9RCDvxvPCT1otxO2IKszJTdyrzluzxKtv/P45NaunLTTROs+rXiJuMIDXrLNX7OLQwuup7rXdxLfZ6BxFwR+/sqoI+xkXF/S7eFtYjQy1+Xgb7ym8802VPZCzsiukJqkGQSTU3XsgXitX7rxbkeVniafeXD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707012210; c=relaxed/simple;
	bh=AUt8VuLGRKU7qxymeevr2SFj22Xexc0ft3yOv6MyTLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLK+hcuc31E/MkQmSQBHfPiWKPzGoHoVagWSDzwaUWs4ZrYIRjV79g2+HIp7PUvurbn/mxImcIJN+PYWANgKLOjFIGfK6p0H10ziG5ZX67ck3VPNa2qVAosL/NwtV6il6/N/1JyHuao+dLiByW7l+vW7/SZcKDQylJqgbA6YOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTPnHY06; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so1831504a12.1;
        Sat, 03 Feb 2024 18:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707012207; x=1707617007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXnV3FuSH15/EZDsqwVdARdYIlKbWNGmlgGyKaw0PvI=;
        b=BTPnHY06/eoB6mXBYqUGd+5UwZvG3g9JuSRg9D5zzZKguiBwlBMIyZCHDbtBSKSUvg
         BBNIBotWuXlSwDnDijkBkpGUD/+ek24o9po1ziLyL6cn9WIAcV09H/s1DTIEZGHel445
         YSnEt0SgmHmQAZdxM2fuy3V+ct4edU1kuRUAHw8jVfRSmfzX9NYS+CnSE9xD6tWKTBiI
         uCX4slHSZQCWTkGuXoBtsOEL40wUTk0PZcWYbyUavtoGsOAH/6TfoEWFpx7mVi97M0EO
         q4ooD7GJgbDY2OPhOO9zjCOLHcU117e6epWhGmSAYxxIhg3KdcjwDNZG7RPnEBv/Tlwh
         VHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707012207; x=1707617007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXnV3FuSH15/EZDsqwVdARdYIlKbWNGmlgGyKaw0PvI=;
        b=U9RVwtHG5nvgPjB1q1Ej43bG0iCWtNcnU1CeV5Fbh4/Lqt7ljXIoZbBJOLniB+HBib
         9uOYk5HSntKuryJ/3lrwrA5qDAUpET07ft/OSFEYj6Sx2AnMCmuVbR4eHRAdoclJ3siG
         MaEONrxQsSUo3K+7ZCDeG7ZPD2+cWaqtpqu4W1SN1iTjb+dc3p0d2mqPnhR9Co9d8uic
         x2EdG7Yd35isFJY2OrgBRDPQjUz9pqci28KB5Nplo0/EEVxj9ifcLrNSUV1MsNSHRQ76
         P8rb5ykm9G1ffLcjdahGlv7XnTauWP44uQ6rQ9HOjFCKmz50oksmkVWq4bSr7DFJEAf6
         MUGg==
X-Gm-Message-State: AOJu0YzQ0Z2LLYIVoV01e/a+LtTHOy21GqTNeCicUw2DDq1A238KneJL
	5oyG1OG76POWLCVlGmTkhMCdsoyFczjVgmoOOJpHufknJK0y9d8lvoIgHu6ojHNfbNbFti+7KKP
	NY95LSL+njkTF5DWQhWLS4X3Sw+s=
X-Google-Smtp-Source: AGHT+IGqmiFmgxvtSlh2/xfVcv0fNlc0wWnA7ES7OVcU/L7aAirs1S/8tfvyn47XiJWr44uKmTBYYZRt8yuvnn0EAYk=
X-Received: by 2002:aa7:d30e:0:b0:560:6a0:c52a with SMTP id
 p14-20020aa7d30e000000b0056006a0c52amr1918535edq.29.1707012207197; Sat, 03
 Feb 2024 18:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122070859.1394479-2-zegao@tencent.com> <20240123070210.1669843-2-zegao@tencent.com>
 <170690725031.1264496.18004455069191563889.b4-ty@kernel.org>
In-Reply-To: <170690725031.1264496.18004455069191563889.b4-ty@kernel.org>
From: Ze Gao <zegao2021@gmail.com>
Date: Sun, 4 Feb 2024 10:03:16 +0800
Message-ID: <CAD8CoPAmB0wB-9JrfsJdiKnCPi026fJ0Qwp9CTpsqjUEvoHZMQ@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Rename get_states() to parse_task_states()
 and make it public
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ze Gao <zegao@tencent.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 4:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, 23 Jan 2024 02:02:11 -0500, Ze Gao wrote:
> > Since get_states() assumes the existence of libtraceevent, so move
> > to where it should belong, i.e, util/trace-event-parse.c, and also
> > rename it to parse_task_states().
> >
> > Leave evsel_getstate() untouched as it fits well in the evsel
> > category.
> >
> > [...]
>
> Applied to perf-tools-next now, thanks for your work!

Thanks for your update! :)

Cheers,
        -- Ze
> --
> Namhyung Kim <namhyung@kernel.org>

