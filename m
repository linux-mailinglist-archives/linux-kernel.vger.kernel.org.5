Return-Path: <linux-kernel+bounces-64869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A6E854413
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2FB1C20E88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADD522E;
	Wed, 14 Feb 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWzSWc1y"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919A399;
	Wed, 14 Feb 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899694; cv=none; b=bmm0lnWNryS18EbxXJfOhd3O0EZkty0Ots0XX+KSkHtzYKc6E8OMrhJ4wFBVl7Al/+um5RYUTjv/l6Guuze0Xhxf27i/kmLU/CP7QtqAHFb5/h1vP9HoZecu2V5bBF277iuAZceKDXIdqEEmupiEAgw56MKifLxr18m1VIQbuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899694; c=relaxed/simple;
	bh=Pc8jOd7teVVjR3r6LIRBXu38f/yDdfTBDx9cr4Flonc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCOMu1OfrkJq4CyGs2zxSL82X8ZoWAe4MltWo+ZF40RCWS/tS1e1vF7AyKIqTdIQPN8vS2puGs6wHHKaLC8MHiCQSvjUZ3FYKaUEgPv/Y3nN9ulhxT50b7uSWtOtjIOu6WfFhk8/BqPoryFPIrVAsDRdlarDAqLzuKSr3EOSfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWzSWc1y; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so688174666b.1;
        Wed, 14 Feb 2024 00:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707899690; x=1708504490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f1tPUAExwT49VcThYqSAawr/yjky803QIJIIWnzaDU=;
        b=LWzSWc1yHL6k/f4CElzzh16vrZM9zcFBGWTKynJm4N5UbUF6Jgs8EbNrtyowDdjofq
         X152PDMjnOK2SMLEaLFohctk/koutOosoriOdJ/gjxb1Z9CcEmDJtB+A5c7MTaHXzvtG
         pai3GEsIvHOmrZqPJaiThNxqBGGXADrV+31nBUnIfRB6JvtYoSrTWx5g+LdNVATs/ubr
         LnScb0BAKUvjpAPie2NSZbJLwqW9LYpdsaWwOKm8/VLLFC9EBN8WpH2edFCFKCxVU9+N
         9NgUldJbXJiBlyx9yFJ6ZWGNMuv9b+YEUuQX01KBJ/TulzWNhcSkx+nQBjxgzusTe1ow
         kfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707899690; x=1708504490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f1tPUAExwT49VcThYqSAawr/yjky803QIJIIWnzaDU=;
        b=pq71na9frhzQ3Kk3nd3iKGVXfLXUGXkEceZyNL037qKXud0qa8zB3GBmoiy4nCFJXs
         9yoToteS9DM6DFH7t2Hi8OWlx6BcFohb8eTYKJdFMAEvzzJCZ2WYxqPlWwdMk/wARFD2
         PYdKCK+c4Kq6uY81kClRv5iStiTpDHUZB7MN5cj7FpamuC1BBw6VnZyqWavUw/d9idt4
         cDVeH2DjBTSF6mWoP2g0gX+8yoDsJKsXLZVUwrv4PVmHM3rOLtA140KZZC+WDLdnZIAh
         565tCKPavoimtUoy5L9ELBcPrfdcY7+p/z4hUmcK8kP8YAnGziVtNTY9pxJ52vHd42Tz
         YtbA==
X-Forwarded-Encrypted: i=1; AJvYcCV0USftHzFdQnrN2cP66SMAyaxXhrocPIu1qhpUgFQPI1h88KaVUkXQ64RlSbehiPZSYhis1KOoRdqtLMweeJ6+2VmRy9Z5WCklVMe6cSIu1sH6tJqoGjhr60uSejX1AgLaYPE/uW64HmrRZcPV89ZxBexaGn1E7RcK8yHCdg21nPE6
X-Gm-Message-State: AOJu0Yxv8w3IELwvNCjEefLeuWwUjieZQqghV5eVZbPjtPNB1C8b/cEB
	FyEw4PYa14Pa4lp/MYS1zjrPbNFiy6UxN2qSg+51A8EdyI4wrypQFuTn7AS3vXzd9B06Eui7NvC
	GMhmrhakwyj4E01wHJ37WhCSXU3XM2gflKsM=
X-Google-Smtp-Source: AGHT+IE0GeITMj6p+AP7XQ7RD36dsjJ88d9XItz0OcRSaVG0Gl3awtxOXaHxnQ+GMGj3ye8rj3ucnvAqpVpsrqknbms=
X-Received: by 2002:a17:906:513:b0:a3d:3aee:85f5 with SMTP id
 j19-20020a170906051300b00a3d3aee85f5mr919663eja.75.1707899689841; Wed, 14 Feb
 2024 00:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024021430-blanching-spotter-c7c8@gregkh>
In-Reply-To: <2024021430-blanching-spotter-c7c8@gregkh>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Wed, 14 Feb 2024 09:34:38 +0100
Message-ID: <CAKXUXMw-xZ_w6prrdTG5Vs=QL1EDvwGv1M9r2PT14LE+HxWUHQ@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:01=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The Linux kernel project now has the ability to assign CVEs to fixed
> issues, so document the process and how individual developers can get a
> CVE if one is not automatically assigned for their fixes.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v3: fix up wording in security-bugs.rst based on the changes to the cve
>     assignment process from v1, thanks to a private reviewer for
>     pointing that out.
> v2: Grammer fixes based on review from Randy
>     Updated paragraph about how CVE identifiers will be assigned
>     (automatically when added to stable trees, or ask us for one
>     directly before that happens if so desired)
>

Hi Greg, Sasha, Lee,

Generally, I think this is a great step forward on the whole "security
vulnerability mess" and this will certainly help me and others in the
embedded space to argue to update to recent stable kernel versions.
This can then finally put the practice of shipping multiple-year-old
kernel versions to an end. Often this was just done with the argument
that there is not a recent CVE and fix assigned to some recent stable
kernel version---and integrators think updates to recent kernel stable
versions are not needed and not recommended.

I am looking forward to seeing what and how many stable commits are
going to get CVEs assigned. If Greg's policy from the Kernel Recipes
2019 presentation comes into play, every git kernel hash (GKH)---at
least in the stable tree---could get a CVE identifier (just to be on
the safe side). But I assume you are going to use some expert
knowledge, heuristics or some machine-learning AI to make some commits
in the stable tree carrying a CVE identifier and some others not.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Below, there is just some nitpicking on some wording:

>  Documentation/process/cve.rst           | 120 ++++++++++++++++++++++++
>  Documentation/process/index.rst         |   1 +
>  Documentation/process/security-bugs.rst |   5 +-
>  3 files changed, 123 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/process/cve.rst
>
> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rs=
t
> new file mode 100644
> index 000000000000..6465e6a79c18
> --- /dev/null
> +++ b/Documentation/process/cve.rst
> @@ -0,0 +1,120 @@
> +CVEs
> +=3D=3D=3D=3D
> +
> +Common Vulnerabilities and Exposure (CVE=C2=AE) numbers were developed a=
s an
> +unambiguous way to identify, define, and catalog publicly disclosed
> +security vulnerabilities.  Over time, their usefulness has declined with
> +regards to the kernel project, and CVE numbers were very often assigned
> +in inappropriate ways and for inappropriate reasons.  Because of this,
> +the kernel development community has tended to avoid them.  However, the
> +combination of continuing pressure to assign CVEs and other forms of
> +security identifiers, and ongoing abuses by community members outside of
> +the kernel community has made it clear that the kernel community should
> +have control over those assignments.
> +

Though, I get what is meant with "the community members outside of the
kernel community", it still feels strange when reading.

Here are some alternatives I could come up with:

"reporters outside the kernel community"
"reporters beyond the actively contributing/engaged kernel community member=
s"
"individuals not engaged with the kernel community"

> +The Linux kernel developer team does have the ability to assign CVEs for
> +potential Linux kernel security issues.  This assignment is independent
> +of the :doc:`normal Linux kernel security bug reporting
> +process<../process/security_bugs>`.
> +
> +A list of all assigned CVEs for the Linux kernel can be found in the
> +archives of the linux-cve mailing list, as seen on
> +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> +assigned CVEs, please subscribe to that mailing list.
> +
> +Process
> +-------
> +
> +As part of the normal stable release process, kernel changes that are
> +potentially security issues are identified by the developers responsible
> +for CVE number assignments and have CVE numbers automatically assigned
> +to them.  These assignments are published on the linux-cve-announce
> +mailing list as announcements on a frequent basis.
> +
> +Note, due to the layer at which the Linux kernel is in a system, almost
> +any bug might be exploitable to compromise the security of the kernel,

Just a nit: but I would say: a kernel bug is compromising the
"security of the system"; the kernel bug just happens to allow anyone
to run any code on their hardware... in some systems that is a
security issue, but in my previous MSDOS system that was the default
behaviour ;)

> +but the possibility of exploitation is often not evident when the bug is
> +fixed.  Because of this, the CVE assignment team is overly cautious and
> +assign CVE numbers to any bugfix that they identify.  This
> +explains the seemingly large number of CVEs that are issued by the Linux
> +kernel team.
> +
> +If the CVE assignment team misses a specific fix that any user feels
> +should have a CVE assigned to it, please email them at <cve@kernel.org>
> +and the team there will work with you on it.  Note that no potential
> +security issues should be sent to this alias, it is ONLY for assignment
> +of CVEs for fixes that are already in released kernel trees.  If you
> +feel you have found an unfixed security issue, please follow the
> +:doc:`normal Linux kernel security bug reporting
> +process<../process/security_bugs>`.
> +
> +No CVEs will be automatically assigned for unfixed security issues in
> +the Linux kernel; assignment will only automatically happen after a fix
> +is available and applied to a stable kernel tree, and it will be tracked
> +that way by the git commit id of the original fix.  If anyone wishes to
> +have a CVE assigned before an issue is resolved with a commit, please
> +contact the kernel CVE assignment team at <cve@kernel.org> to get an
> +identifier assigned from their batch of reserved identifiers.
> +
> +No CVEs will be assigned for any issue found in a version of the kernel
> +that is not currently being actively supported by the Stable/LTS kernel
> +team.  A list of the currently supported kernel branches can be found at
> +https://kernel.org/category/releases.html
> +
> +Disputes of assigned CVEs
> +-------------------------
> +
> +The authority to dispute or modify an assigned CVE for a specific kernel
> +change lies solely with the maintainers of the relevant subsystem
> +affected.  This principle ensures a high degree of accuracy and
> +accountability in vulnerability reporting.  Only those individuals with
> +deep expertise and intimate knowledge of the subsystem can effectively
> +assess the validity and scope of a reported vulnerability and determine
> +its appropriate CVE designation.  Any attempt to modify or dispute a CVE
> +outside of this designated authority could lead to confusion, inaccurate
> +reporting, and ultimately, compromised systems.
> +
> +Invalid CVEs
> +------------
> +
> +If a security issue is found in a Linux kernel that is only supported by
> +a Linux distribution due to the changes that have been made by that
> +distribution, or due to the distribution supporting a kernel version
> +that is no longer one of the kernel.org supported releases, then a CVE
> +can not be assigned by the Linux kernel CVE team, and must be asked for
> +from that Linux distribution itself.
> +
> +Any CVE that is assigned against the Linux kernel for an actively
> +supported kernel version, by any group other than the kernel assignment
> +CVE team should not be treated as a valid CVE.  Please notify the
> +kernel CVE assignment team at <cve@kernel.org> so that they can work to
> +invalidate such entries through the CNA remediation process.
> +
> +Applicability of specific CVEs
> +------------------------------
> +
> +As the Linux kernel can be used in many different ways, with many
> +different ways of accessing it by external users, or no access at all,
> +the applicability of any specific CVE is up to the user of Linux to
> +determine, it is not up to the CVE assignment team.  Please do not
> +contact us to attempt to determine the applicability of any specific
> +CVE.
> +
> +Also, as the source tree is so large, and any one system only uses a
> +small subset of the source tree, any users of Linux should be aware that
> +large numbers of assigned CVEs are not relevant for their systems.
> +
> +In short, we do not know your use case, and we do not know what portions
> +of the kernel that you use, so there is no way for us to determine if a
> +specific CVE is relevant for your system.
> +
> +As always, it is best to take all released kernel changes, as they are
> +tested together in a unified whole by many community members, and not as
> +individual cherry-picked changes.  Also note that for many bugs, the
> +solution to the overall problem is not found in a single change, but by
> +the sum of many fixes on top of each other.  Ideally CVEs will be
> +assigned to all fixes for all issues, but sometimes we do not notice
> +fixes in released kernels, so do not assume that because a specific
> +change does not have a CVE assigned to it, that it is not relevant to
> +take.
> +
> diff --git a/Documentation/process/index.rst b/Documentation/process/inde=
x.rst
> index 6cb732dfcc72..de9cbb7bd7eb 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -81,6 +81,7 @@ of special classes of bugs: regressions and security pr=
oblems.
>
>     handling-regressions
>     security-bugs
> +   cve
>     embargoed-hardware-issues
>
>  Maintainer information
> diff --git a/Documentation/process/security-bugs.rst b/Documentation/proc=
ess/security-bugs.rst
> index 692a3ba56cca..56c560a00b37 100644
> --- a/Documentation/process/security-bugs.rst
> +++ b/Documentation/process/security-bugs.rst
> @@ -99,9 +99,8 @@ CVE assignment
>  The security team does not assign CVEs, nor do we require them for
>  reports or fixes, as this can needlessly complicate the process and may
>  delay the bug handling.  If a reporter wishes to have a CVE identifier
> -assigned, they should find one by themselves, for example by contacting
> -MITRE directly.  However under no circumstances will a patch inclusion
> -be delayed to wait for a CVE identifier to arrive.
> +assigned for a confirmed issue, they can contact the :doc:`kernel CVE
> +assignment team<../process/cve>` to obtain one.
>
>  Non-disclosure agreements
>  -------------------------
> --
> 2.43.1
>
>

