Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8475A622
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGTGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGTGQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:16:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F8E1734;
        Wed, 19 Jul 2023 23:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689833774; x=1690438574; i=deller@gmx.de;
 bh=Kjw2irROZgblodT7GrAJHMiu+Athn4WIlCQc+MmBJFk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Khj07uLafxC6/VVXXkBDAjAu7oB2EGZcI3RZB5LLkQ1wruAOXcLmV2/e+D4BSxfOFTIHc2Q
 +j+2DZOExBgmFygHcj+X1Bx/hLP2JH8wpr+UMh0rN6yWZBDtKFhtSFC5GkK95xC1v1oUmB4yN
 1/JQhBFPKq1E+ukuWhZMtjPrBIkeHfX2y9EIe6sLPzKduhJ5c1y0+hbleJhh30vYPX7cIFekx
 O4D8yjCBUchNyS+A0gMCANQeDW1NfDYTYxgQm8BJamxlLCSK6eRTraa/JIQYt7UvW7HT1vPHp
 HOFQSLdWY7He6YBL8uLFWtdvjR6KBT38uiE1lMZZTjvGQoXOzr3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.9]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1psUGY0o0i-015MvO; Thu, 20
 Jul 2023 08:16:14 +0200
Message-ID: <1d045caf-2d83-047d-654b-03609dd91226@gmx.de>
Date:   Thu, 20 Jul 2023 08:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/7] vgacon: switch vgacon_scrolldelta() and
 vgacon_restore_screen()
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230712085942.5064-1-jirislaby@kernel.org>
 <20230712085942.5064-2-jirislaby@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230712085942.5064-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/YaYnmNmwmNBiWSeAkIditEiEjLVWWmnI18FP3ynD9r/fckEMQI
 4b/nP4E1xU52qYKfV8mXxZucwJGyJ1CO0/TqG59roNw7gJmnzD/+lxXMeJQQISqccF8u3Mo
 Egq3e3eUY4/E8WhLyXOa58UDopMmHgsHgYy1ZRhuRx02tkB2eNUUqe0VkWgw0Cp8xEz1f/7
 uQwASgZY4DUa4br5GrfIg==
UI-OutboundReport: notjunk:1;M01:P0:veCzuI3kDCg=;fnRmKSxZXEjl/taCOx7paUHzly4
 6XIDPwcabiiLuhF8P9PH0QhJ2joy9vduzgs2TBQiObO6tMDmEpeyxoMK+3D0xNJisj9uzOPKy
 nIpe0/ks4u5epwpY/INb08DS3by66ee73PqhUdzjtlX5giddyP8YE8AfvhcCTzGj8N2nwsLm0
 Q34prT4RT9+z0tIVHsR32na/yCLqeFtIqXs4eO5/DBpCz21+FSOxjBlFssyVkTHcPRgKwXYPO
 bd1YBu9PQL9oTrlUUVejFwtNv6TAIt+joOo9ANKe7wsfoq7CHHCu39Qna5whFwStbjCCwj2Ow
 bKh33Vs/e/Va+/hBq8jN31WV7YhCu9vPWnaMdRp9xDTfvdyjwRRBvxkrnEHTlBzhkqOHn2N5A
 41Lm2fM0DbqgFBoeygWj7X2fPzmtNkYzRQuwNbl0q0lbQsYnVgd0GCM6vz8jFcr5egJ9TD0pV
 d36IDEvKmbDcxauweuklHaoZeTPWkYBBpaY2rSpwXPAjFUEg/JZhPDhyY4Hzq1Gxh+g6zpYq9
 BaXIdm1yhhEz/vcr+DAipEITQB6J5NPlpKJtWIAHhnKbr0FonuqZ8P05BsYZYTIQ1j+v8aho9
 cULpRquSsxNDzjbtWvTv7qr9El2WO1qyiFAfrxOSXz5I2aWY9HPgNZJVKRYSpIcNPjxPTagXl
 ZdPwWX5cOwJDBMVEkdsSvBZPSVHhy7MTJpCk3HyoQzTsVkZTBiqUrQR5J6hlOb+yBDViILNvt
 YvgcU3kMNL1wyZIaRpjbKu+cKrOjVJuFUxeJIsssT1SifMuhrCCBAVh0A3ww+pVf5w3wN+iQd
 KkN9/K4qyJZq8Mqfhl+Iol92FIb5qJRdAG2DQu0Mse7eaPKybkMLsXK6YbzOYHcUAIOmzMFMQ
 SREHPu5bhH181wkGmmLEIP/6ZBSdKB4MBgix/EwCT5eAvoT4VfIYulomX40JHvAgKFPiYNx+3
 XHk2ZA==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 10:59, Jiri Slaby (SUSE) wrote:
> Switch vgacon_scrolldelta() and vgacon_restore_screen() positions, so
> that the former is not needed to be forward-declared.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

Thanks Jiri !
I've applied this series to the fbdev git tree.

Helge

> ---
>   drivers/video/console/vgacon.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgac=
on.c
> index e25ba523892e..fbed2862c317 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -142,12 +142,6 @@ static inline void vga_set_mem_top(struct vc_data *=
c)
>   	write_vga(12, (c->vc_visible_origin - vga_vram_base) / 2);
>   }
>
> -static void vgacon_restore_screen(struct vc_data *c)
> -{
> -	if (c->vc_origin !=3D c->vc_visible_origin)
> -		vgacon_scrolldelta(c, 0);
> -}
> -
>   static void vgacon_scrolldelta(struct vc_data *c, int lines)
>   {
>   	vc_scrolldelta_helper(c, lines, vga_rolled_over, (void *)vga_vram_bas=
e,
> @@ -155,6 +149,12 @@ static void vgacon_scrolldelta(struct vc_data *c, i=
nt lines)
>   	vga_set_mem_top(c);
>   }
>
> +static void vgacon_restore_screen(struct vc_data *c)
> +{
> +	if (c->vc_origin !=3D c->vc_visible_origin)
> +		vgacon_scrolldelta(c, 0);
> +}
> +
>   static const char *vgacon_startup(void)
>   {
>   	const char *display_desc =3D NULL;

