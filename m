Return-Path: <linux-kernel+bounces-143081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB52C8A33D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D641C2138C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062314A62E;
	Fri, 12 Apr 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpXCTOHd"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CD149C7A;
	Fri, 12 Apr 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939182; cv=none; b=Rfsu9VD2iNOrRg1BnrLe427yYyRF+s6teewj6sLbwVuADatrjkjx4iqnncNBKaHA7r4Ik/UacLRvlDxJPIj2u+uLh9VBf+zGPVy+Ie4uhcUm7MwfLbD+53Vtcu498DtENnfV5CXSDohXyAK3I4JjA7RswmP96hcE5k+op86f2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939182; c=relaxed/simple;
	bh=U+YWaM+j4UuQyut7B3+N2UnJU+GDXIKNdsx/erJ8ups=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoUMPL9kBaWeTgZIOmd/a/oHr/Hwmdp8cicFGYN5DcY/noDtH5PBaIsC88qNiXGxn2a0spMuwvy9AaGnEHY+s6LOgunxfEvd/xCV5HjqTJftDSKkMEOJv58mjOg7ETjkVb367QP2c++oq8Qg2cWaQI9qAxjiqYB1w3Sm+HXImXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpXCTOHd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so3726198a12.1;
        Fri, 12 Apr 2024 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712939179; x=1713543979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S5rYRAIdwELL1njRKzrVzsrzJoQnchOez5tsdfUvaI=;
        b=hpXCTOHdJfRFu+r8x1w3WX/GlQ6ChYRnTrsd8JQzpeHZjCiYDSogoS9B5ouzPfrVRb
         UFHlM/3Sh+UW+2Py0x58DEFoST4gZHWQXnuxmilRMfRLCeC1QHwfh3rWr0YsKW9CtphT
         2Ib5wUoEEoJ9coI1o6JwIxZ2Waxmq9uLXSCigk3xgg9NPZd14mC+5meVw8atmDG7+c7+
         UfFX+eCMwro8UePmewm/eKr3AoAC2aGN9jXEajA0VbRqfuiwMf8xhph9yCVyYpaqxeSB
         WDFO2bZTedXUxrO4t3GWgud0URF6Xb7NhXz7S4kxTimA6fZbX28pt0dieLW6PWs5LRIG
         dj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712939179; x=1713543979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7S5rYRAIdwELL1njRKzrVzsrzJoQnchOez5tsdfUvaI=;
        b=PN5wtSGN7L9wPmf03nbAG/Mi6hLkUIvklpz3iONyD6lgm4m72VadNROobwTFXVFPgQ
         BKs4yRn1xKQyNTtMkPbX8UrCkHQngfCxTAj0HHdTRuhWnXLkaATn8OSdRykc0UlyhizZ
         DcAV2Ze2TiRAW9hzq+WVWmPYtMv92WFuoPU+60+X0xJcZ8iYbcrAg0Tvpx4pJV29EuXy
         3sfwLplzwQn46GdPcpRdLIvOqMIaBQXLN985iDZfpuBC2ebqlDN1dLc1ZqiOYgyCkMvl
         /yYz108s2L2Wv2i8YBwXx29/KJi0S+WJ6B+ADYGtqaGGkNouWDXK5O9HUy8B0KZ91q/s
         n/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsHZKQlVJWyX+V/Yz1KOzOUudeoItgPBGUlNXn0HJAqk+t4VGrOQhTTQbZ5r5zv9z7V8uJdQwJzflz5QVvCJr26bKnx8XGqBus
X-Gm-Message-State: AOJu0YwfLagYlI/kn1Ie3Q25ywBL9jvcgTyzCtxpc+4hRJsnJVlOWQ7l
	rRhOgLQeCS44l0bbtzDtDlvRBkw09o7wwI79CCg6sv3PKAdl/zQCVXG9Brw7508R5SIGktOu9cl
	8liaRmMYfWjq/GbeoAdEZkB2XhwA=
X-Google-Smtp-Source: AGHT+IFtsWE4u2myVJNDdXFTPZxZyeTY/cqwP7h2PooKBdw+iLcodyBMcYwspj3CY0TwSvh5JKJYgeCOyJhpLN4xhMY=
X-Received: by 2002:a17:906:5604:b0:a52:3e27:b5a8 with SMTP id
 f4-20020a170906560400b00a523e27b5a8mr866580ejq.1.1712939178996; Fri, 12 Apr
 2024 09:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com> <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
In-Reply-To: <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
From: Sam Sun <samsun1006219@gmail.com>
Date: Sat, 13 Apr 2024 00:26:07 +0800
Message-ID: <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in disable_store
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org, ricardo@marliere.net, 
	hkallweit1@gmail.com, heikki.krogerus@linux.intel.com, 
	mathias.nyman@linux.intel.com, royluo@google.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 10:40=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, Apr 12, 2024 at 09:08:12PM +0800, Sam Sun wrote:
> > Sorry for the mistake I made when debugging this bug. Now I have more
> > information about it. Disassembly of function disable_store() in the
> > latest upstream kernel is listed below.
> > ```
> > Dump of assembler code for function disable_store:
> >    ...
> >    0xffffffff86e907eb <+187>:   lea    -0x8(%r14),%r12
> >    0xffffffff86e907ef <+191>:   mov    (%rbx),%rax
> >    0xffffffff86e907f2 <+194>:   mov    %rax,0x20(%rsp)
> >    0xffffffff86e907f7 <+199>:   lea    -0xa8(%rax),%rdi
> >    0xffffffff86e907fe <+206>:   mov    %rdi,0x18(%rsp)
> >    0xffffffff86e90803 <+211>:   call   0xffffffff86e20220
> > <usb_hub_to_struct_hub>
> >    0xffffffff86e90808 <+216>:   mov    %rax,%rbx
> >    0xffffffff86e9080b <+219>:   shr    $0x3,%rax
> >    0xffffffff86e9080f <+223>:   movabs $0xdffffc0000000000,%rcx
> >    0xffffffff86e90819 <+233>:   cmpb   $0x0,(%rax,%rcx,1)
> >    0xffffffff86e9081d <+237>:   je     0xffffffff86e90827 <disable_stor=
e+247>
> >    0xffffffff86e9081f <+239>:   mov    %rbx,%rdi
> >    0xffffffff86e90822 <+242>:   call   0xffffffff81eeb0b0
> > <__asan_report_load8_noabort>
> >    0xffffffff86e90827 <+247>:   lea    0x60(%rsp),%rsi
> >    ...
> > ```
> > The cmpb in disable_store()<+233> is generated by KASAN to check the
> > shadow memory status. If equals 0, which means the load 8 is valid,
> > pass the KASAN check. However, this time rax is 0, so it first
> > triggers general protection fault, since 0xdffffc0000000000 is not a
> > valid address. rax contains the return address of function
> > usb_hub_to_struct_hub(), in this case is a NULL.
> >
> > In function usb_hub_to_struct_hub(), I checked hdev and its sub
> > domains, and they are not NULL. Is it possible that
> > usb_deauthorized_device() set
> > hdev->actconfig->interface[0]->dev.driver_data to NULL? I cannot
> > confirm that since every time I try to breakpoint the code it crashes
> > differently.
>
> I suspect the usb_hub_to_struct_hub() call is racing with the
> spinlock-protected region in hub_disconnect() (in hub.c).
>
> > If there is any other thing I could help, please let me know.
>
> Try the patch below.  It should eliminate that race, which hopefully
> will fix the problem.
>
> Alan Stern
>
>
>
> Index: usb-devel/drivers/usb/core/hub.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/hub.c
> +++ usb-devel/drivers/usb/core/hub.c
> @@ -72,6 +72,9 @@
>   * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. *=
/
>  static DEFINE_SPINLOCK(device_state_lock);
>
> +/* Protect hdev->maxchild and hub's intfdata */
> +static DEFINE_SPINLOCK(hub_state_lock);
> +
>  /* workqueue to process hub events */
>  static struct workqueue_struct *hub_wq;
>  static void hub_event(struct work_struct *work);
> @@ -152,9 +155,13 @@ static inline char *portspeed(struct usb
>  /* Note that hdev or one of its children must be locked! */
>  struct usb_hub *usb_hub_to_struct_hub(struct usb_device *hdev)
>  {
> -       if (!hdev || !hdev->actconfig || !hdev->maxchild)
> -               return NULL;
> -       return usb_get_intfdata(hdev->actconfig->interface[0]);
> +       struct usb_hub *hub =3D NULL;
> +
> +       spin_lock_irq(&hub_state_lock);
> +       if (hdev && hdev->actconfig && hdev->maxchild)
> +               hub =3D usb_get_intfdata(hdev->actconfig->interface[0]);
> +       spin_unlock_irq(&hub_state_lock);
> +       return hub;
>  }
>
>  int usb_device_supports_lpm(struct usb_device *udev)
> @@ -1714,7 +1721,9 @@ static int hub_configure(struct usb_hub
>                         break;
>                 }
>         }
> +       spin_lock_irq(&hub_state_lock);
>         hdev->maxchild =3D i;
> +       spin_unlock_irq(&hub_state_lock);
>         for (i =3D 0; i < hdev->maxchild; i++) {
>                 struct usb_port *port_dev =3D hub->ports[i];
>
> @@ -1790,9 +1799,11 @@ static void hub_disconnect(struct usb_in
>
>         /* Avoid races with recursively_mark_NOTATTACHED() */
>         spin_lock_irq(&device_state_lock);
> +       spin_lock(&hub_state_lock);
>         port1 =3D hdev->maxchild;
>         hdev->maxchild =3D 0;
>         usb_set_intfdata(intf, NULL);
> +       spin_unlock(&hub_state_lock);
>         spin_unlock_irq(&device_state_lock);
>
>         for (; port1 > 0; --port1)
>

I applied this patch and tried to execute several times, no more
kernel core dump in my environment. I think this bug is fixed by the
patch. But I do have one more question about it. Since it is a data
race bug, it has reproducibility issues originally. How can I confirm
if a racy bug is fixed by test? This kind of bug might still have a
race window but is harder to trigger. Just curious, not for this
patch. I think this patch eliminates the racy window.

Best,
Yue

